# Better for heroku performance
console.log = if global.process.env.NODE_ENV? and global.process.env.NODE_ENV is 'production' then () -> else console.log

# dependencies
express = require('express');
routes = require('./routes');

http = require('http');
path = require('path');
app = express();
global.app = app;
mongoose = require('mongoose');
config = require('./config');
passport = require('passport');
user = require('./models/user')
GlobalAnswer = require('./models/answers')
answer_requests = require('./routes/answer_requests');
account_settings = require('./routes/settings');
vote = require('./routes/vote');

FacebookStrategy = require('passport-facebook').Strategy;
TwitterStrategy = require('passport-twitter').Strategy;
GoogleStrategy = require('passport-google').Strategy;
fs = require('fs')


# config = require('./oauth.js')

# connect to mongo
mongoose.connect(process.env.MONGOHQ_URL or config.mongoUrl);



# user = mongoose.model('User')
# GlobalAnswer = mongoose.model('GlobalAnswer')

# passport settings
passport.serializeUser (user,done) ->
	done(null, user.id);


passport.deserializeUser (id, done) ->
	user.findOne {_id : id}, (err, user) ->
		done(err,user);

passport.use(new GoogleStrategy({returnURL: config.google.returnURL, realm: config.google.realm}, (identifier, profile, done) ->
	console.log("YEAH",profile.emails[0].value)
	process.nextTick () ->
		query = user.findOne({'email': profile.emails[0].value});
		query.exec (err, oldUser) ->
			
			if (oldUser)
				console.log("Found registered user: " + oldUser.name + " is logged in!");
				done(null, oldUser);
			else
				# location data function
				# getIP = (ip, location) ->
				# 	url = 'http://freegeoip.net/json/' + ip
				# 	request.get url, (error, response, body) ->
				# 		if !error and response.statusCode == 200
				# 			return data = JSON.parse body
				newUser = new user();
				newUser.name = profile.displayName;
				newUser.email = profile.emails[0].value;
				
				newDate = new Date()
				# newUser.location = getIP(newUser.ip)
				console.log("newDate",newDate)
				newUser.date = newDate
				console.log(newUser);
				newUser.save (err) ->
					if(err) 
						throw err;
					
					console.log("New user, " + newUser.name + ", was created");
					done(null, newUser);
));


# config - all environments
app.set('port', process.env.PORT || 1337);
app.set('views', __dirname + './../views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.cookieParser());
app.use(express.bodyParser());
app.use(express.session({secret:'c00kies-@nd-cr3@M'}));
app.use(passport.initialize());
app.use(passport.session());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(__dirname + './../public'));

# config - development only
if ('development' == app.get('env'))
	app.use(express.errorHandler());

# Import Config
config = require('./config.js');
app.locals.config = config;

# Import navigation links
app.locals.links = require('./navigation');

# auth routes
app.get '/auth/google', 
	passport.authenticate('google', {scope:'email'}),
	(req, res) ->

app.get '/auth/google/callback', passport.authenticate('google', { failureRedirect: '/' }), (req, res) ->
	res.redirect req.session.redirectURL ? '/main'

# authentication helper
ensureAuthenticated = (req, res, next) ->
	return next() if req.isAuthenticated()
	res.redirect('/login');
	next()

# user routes
app.get('/', routes.index);
app.get '/settings', ensureAuthenticated, (req, res) ->
	res.render 'partials/settings'

app.get('/answers', routes.answers)
app.get('/seeanswers',ensureAuthenticated, routes.seeanswers)
app.get('/rank',ensureAuthenticated, routes.rank)
app.get('/results',ensureAuthenticated, routes.results)
app.get '/mission', routes.mission
app.get('/main', ensureAuthenticated, routes.main);
app.get('/login', routes.login)
# app.get('/populateDOM', routes.populateDOM)
app.get '/logout', (req, res) ->
	req.logOut();
	res.redirect('/');

app.get '/error', (req,res) ->
	res.send(401,'{err: please log in!}');

# require('./routes/router')(GlobalAnswer, app, user).sendanswer
# require('./routes/router')(GlobalAnswer, app, user).getanswers

# answers to initial question
app.get '/sendanswer', answer_requests.sendanswer
# get answers from database
app.get '/getanswers', answer_requests.getanswers
app.get "/newsettings",account_settings.newsettings
app.get "/loadsettings",account_settings.loadsettings

app.get "/upvote", vote.upvote
# run server
http.createServer(app).listen app.get('port'), () ->
	console.log('\nRealize Change is up and listening on port ' + app.get('port'));


