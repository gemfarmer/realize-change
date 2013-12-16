config = { 
	production:
		{
			google: {
				returnURL: 'http://realize-change.herokuapp.com/auth/google/callback',
				realm: 'http://realize-change.herokuapp.com/'
			},
			twitter: {

			},
			mongoUrl: 'mongodb://localhost/realizeChange',
			title: 'RealizeChange.org',
			subtitle: 'Making dreams come true...'
		}
	development:
		{ 
			google: {
				returnURL: 'http://localhost:1337/auth/google/callback',
				realm: 'http://localhost:1337/'
			},
			twitter: {
	
			},
			mongoUrl: 'mongodb://localhost/realizeChange',
			title: 'RealizeChange.org',
			subtitle: 'Making dreams come true...'
		}
}
# module.exports = config.production
module.exports = if (global.process.env.NODE_ENV == 'production') then config.production else config.development



