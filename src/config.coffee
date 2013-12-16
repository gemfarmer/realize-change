config = { 
	production:
		{
			google: {
				returnURL: 'http://realize-change-now.herokuapp.com/auth/google/callback',
				realm: 'http://realize-change-now.herokuapp.com/'
			},
			paypal : {
				returnURL : 'http://realize-change-now.herokuapp.com/paypals/execute',
				cancelURL : 'http://realize-change-now.herokuapp.com/paypals/cancel'
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
			paypal : {
				returnURL : 'http://localhost:1337/paypals/execute',
				cancelURL : 'http://localhost:1337/paypals/cancel'
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



