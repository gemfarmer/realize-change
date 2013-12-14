# Better for heroku performance
console.log = if global.process.env.NODE_ENV? and global.process.env.NODE_ENV is 'production' then () -> else console.log

# dependencies
express = require('express');
routes = require('./routes');
api = require('./routes/api');
answer_requests = require('./routes/answer_requests');
http = require('http');
path = require('path');
app = express();
global.app = app;
mongoose = require('mongoose');
config = require('./config');
user = require('./Models/User')
passport = require('passport');

FacebookStrategy = require('passport-facebook').Strategy;
TwitterStrategy = require('passport-twitter').Strategy;
GoogleStrategy = require('passport-google').Strategy;
# config = require('./oauth.js')


# connect to mongo
mongoose.connect(process.env.MONGOHQ_URL or config.mongoUrl);

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
				newUser = new user();
				newUser.name = profile.displayName;
				newUser.email = profile.emails[0].value;
				console.log(newUser);
				newUser.save (err) ->
					if(err) 
						throw err;
					
					console.log("New user, " + newUser.name + ", was created");
					done(null, newUser);
));
# passport.use(new TwitterStrategy({
# 	consumerKey: 'TWITTER_CONSUMER_KEY',
# 	consumerSecret: 'TWITTER_CONSUMER_SECRET',
# 	callbackURL: "http://127.0.0.1:1337/auth/twitter/callback"
# }, (token, tokenSecret, profile, done) ->
# 	# asynchronous verification, for effect...
# 	process.nextTick () ->
	  
# 	# To keep the example simple, the user's Twitter profile is returned to
# 	# represent the logged-in user.  In a typical application, you would want
# 	# to associate the Twitter account with a user record in your database,
# 	# and return that user instead.
# 		return done(null, profile);
# ));

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
	res.redirect('/main');

# app.get('/auth/twitter', passport.authenticate('twitter'));

# Twitter will redirect the user to this URL after approval.  Finish the
# authentication process by attempting to obtain an access token.  If
# access was granted, the user will be logged in.  Otherwise,
# authentication has failed.
# app.get('/auth/twitter/callback', passport.authenticate('twitter', { successRedirect: '/', failureRedirect: '/login' }));

# authentication helper
ensureAuthenticated = (req, res, next) ->
	if (req.isAuthenticated())
		return next()
	res.redirect('/error');

# user routes
app.get('/', routes.index);
# app.get('/partials/:name', ensureAuthenticated, routes.partials);

app.get('/answers', routes.answers)
app.get('/seeanswers', routes.seeanswers)
app.get('/rank', routes.rank)
app.get('/results', routes.results)
app.get '/mission', routes.mission
app.get('/main', ensureAuthenticated, routes.main);
app.get '/logout', (req, res) ->
	req.logOut();
	res.redirect('/');

app.get '/error', (req,res) ->
	res.send(401,'{err: please log in!}');


# answers to initial question
app.get '/sendanswer', answer_requests.sendanswer
# get answers from database
app.get '/getanswers', answer_requests.getanswers


# run server
http.createServer(app).listen app.get('port'), () ->
	console.log('\nRealize Change is up and listening on port ' + app.get('port'));


