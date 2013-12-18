# RealizeChange
=============
### To Setup

####To start (mac):
1. Go to Terminal in Applications folder, 
	* type `cd /usr/local` then enter
	* type `brew install` then enter to install homebrew
2. Download/Install node.js: http://nodejs.org/
3. Install MongoDB
	* type `brew update` then enter
	* type `brew install mongodb`
	* type `mongodb &` - this will run mongodb in the background
	* type `disown %1` - this will detach mongodb from the current shell
# After Install
1. In Terminal: `npm install`
2. `npm install -g supervisor`
3. `cake dev`
4. Go to your browser: http://localhost:1337/


### Pages
On trying to answer questions-->( why you should register Modal)
1. Splash, Basic about, Answer Questions
2. See Answers (globals) (locked)
	* Read Dreams, Vote on Goals
	* Randomize: One question and one random
3. Map- see other's dreams (Geocharts) (locked)
4. Data Visualization (draws user specific data) (locked)
5. Login
	* Profile settings to get user specific information
6. Donate (paypal)
7. Dropdown
	* About Us
	* Mission

### TO DO
1. Mobile Stuff
	* Switch click events to tap events 
	* settings doesn't work on mobile
	* asc and desc on rankings don't work
	* auto focus on dreams page
2. Limit number of rankings to 10. Add see more button
3. Make sure that the More? button on dreams page disappears once all have been viewed
4. Add timestamp to new users and globalanswers
5. Add tips ? icon and expanation on each page
6. Redo ranking system so to limit overlap
7. General speed enhancements

###Brian Mingus Suggestions
1. - Vote4goals took seconds to load
2. - Fonts are too small - I zoomed in to 150% and that looked about right
DONE 3. - Email address is unprofessional
4. - Donate button could be more prominent - there is room in the header for a bar or a %goal achieved statistic.
5.- Likewise, the Vote for us on IdeaScale button could be in the banner.
DONE 6.- The cloud icon could go with "Begin Dreaming", and an info (circle with i inside?) icon with About Us
7.- The submit answers button on the answer page is not centered
8- I might have gotten logged out?
9- The Vote4goals page is not intuitively clear enough about what is going on. At the very least I would stick the responses in equal width boxes so you don't have to move your mouse around as much. A small explanation about what's going on here might be helpful: The more you vote the more you effect change. Also, maybe this section should be Vote4Change ?
10- Definitely getting logged out.
11- The gap between the header and the content is too large.
12.- On the seeanswers page the All Dreams listing is not rendering correctly. The bottom wrapped portion of this sentence wrenders on top of the top portion: "My hopes : wishing every part of my family and friend.. happy and healthy for ever.. more better than now... My dreams : working overseas, learn more about business and create my own business."
<!-- 1. DONE Switch sorting on results page. DONE Reverse order of object sent to dom . Limit number of goals to display
2. Add error on pages when user tries to enter restricted page
DONE 3. Comment out recursive aspect to randomize feature.
4. Gut and seed database
5. Add padding to bottom, sides(when small)
DONE 6. Change text on front page.
7. Alter settings so that undefined does not come up
Done 8. Add guest user default in schema
DONE 9. Force user to enter something into both forms
DonE 10. Add quest with sessions
 -->
<!-- 

Configure rank queries so that they exlude any id's of the optionsSeen from the potential options
2. If user has added account settings, feed them into the form using handlebars
3. When user clicks 'show dreams', reduce number shown to ten, and use pagination
4. Add Sorting capabilities to results page. carat up, carat down
5. Sort out user accessibility issues so that user can only be on correct pages
6. Redo form format with selects
	* Feed country data into country dropdown from google api. Store in a dummy array
		* Or gather ip on click information. Add disclaimer to site that we are adding information.
	* Make form a modal
7. Connect country data to geocharts, move geochart to dreams page
8. Add data visualization page
9. Based on detre's input, consolidate see answers, rank, and results page into one page with separate tabs (pillbox styling)
10. Currently you can't vote without logging in. Change that.
11. Add character limit to begin dreaming page
12. Make sure dream submission returns green success box.
13. After dreams submission form is completed, remove from DOM. replace with new form asking "What other questions should we ask?" Add a question or click "no thanks". Add geocharts to DOM.
14. Paypal integration--what do we need?
15. 500 char limit on dreams ->, 200 on goals. text below indicated remaining chars
 -->

Paypal stuff
-------------
https://devblog.paypal.com/building-a-web-app-with-node-js-the-paypal-sdk-part-2/

<!-- 
1. Reconfigure db structure 
	* User should have 
		* Own set of answers
		* An array with list of answers that they have voted on (so that they don't repeat vote)
		* user demographics data
		* location?
2. Under the login dropdown, add access to Account Settings information. Have option to fill out demographic information (country, state/province, city, ethnicity, age, gender, etc.)
3. Be able to vote
	* voting will add one vote to the answer with the matching global answer id
	* voting will add both answer options to the user's list of "options seen"
4. Add Results page that sorts answers based on their popularity (only display top 10?)
	* Add data visualization page with votes sorted by demographic data
5. Geocharts showing location of users
6. Add content--add styles -->

When up the site is located here: http://realizechange.herokuapp.com
![Full](/public/img/full.png)
![Compressed](/public/img/compressed.png)

