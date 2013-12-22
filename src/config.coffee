# seedData = [
# 	{
# 		answerGoals: "We should come together as a planet"
# 		answerFuture: "My hopes : wishing every part of my family and friend.. happy and healthy for ever.. more better than now... My dreams : working overseas, learn more about business and create my own business."		
# 	}
# 	{
# 		answerGoals: "I think we should strive to stregthen the world economy"
# 		answerFuture: "My hopes and dreams for the future are to find a full-time permanent job, and to hopefully marry and get settled down."		
# 	}
# 	{
# 		answerGoals: "We should focus on citizen participation so that our government will work for us"
# 		answerFuture: "A truly united Nigeria that is devoid of tribal problems , leaders making policies that will affect the commoners, improvement in infrastructures, access to good quality education , a much more industrialized nation that is at peace."		
# 	}
# 	{
# 		answerGoals: "More fiscal responsibility and government accountabitity"
# 		answerFuture: "Drastic reduction in the cost of running government. Channel funds accrued from previous waste areas into building basic infrastructure and providing adequate security. Youth employment."
# 	}
# 	{
# 		answerGoals: "We should try to fight climate change. I miss snow days!"
# 		answerFuture: "I hope that my future children can live in a world that is as beautiful as the one we are currently inhabiting"
# 	}
# 	{
# 		answerGoals: "I think we should aim for continue pushing for human rights. It cannot stop until people feel free."
# 		answerFuture: "I have a dream that my four little children will me day live in a nation where they will not be judged by the color of their skin, but by the content of their character"
# 	}

# ]

config = { 
	production:
		{
			google: {
				returnURL: 'http://realizechange.herokuapp.com/auth/google/callback',
				realm: 'http://realizechange.herokuapp.com/'
			},
			twitter: {

			},
			mongoUrl: 'mongodb://localhost/realize-change',
			title: 'Realize Change',
			subtitle: 'Let’s dream together...',
			info: {
				answers: "Please enter one dream and one goal that you have for the future. They do not have to be related.",
				seeanswers: 'Click on "All Dreams" to see all the dreams',
				rank: "Vote for the goal that you prefer. If you do not like either of them, vote for the lesser of two evils.",
				results: "These are the results from the Vote4Change section. Use the icons to sort the list based on vote totals",
				mission: "This is more information about our project"
			}
			# initialAnswers: seedData
		}
	development:
		{ 
			google: {
				returnURL: 'http://localhost:1337/auth/google/callback',
				realm: 'http://localhost:1337/'
			},
			twitter: {
	
			},
			mongoUrl: 'mongodb://localhost/realize-change',
			title: 'Realize Change',
			subtitle: 'Let’s dream together...',
			info: {
				answers: "Please enter one dream and one goal that you have for the future. They do not have to be related.",
				seeanswers: 'Click on "All Dreams" to see all the dreams',
				rank: "Vote for the goal that you prefer. If you do not like either of them, vote for the lesser of two evils.",
				results: "These are the results from the Vote4Change section. Use the icons to sort the list based on vote totals",
				mission: "This is more information about our project"
			}
			# initialAnswers: seedData
		}
}
# module.exports = config.production
module.exports = if (global.process.env.NODE_ENV == 'production') then config.production else config.development



