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

1. DONE Switch sorting on results page. DONE Reverse order of object sent to dom . Limit number of goals to display
2. Add error on pages when user tries to enter restricted page
DONE 3. Comment out recursive aspect to randomize feature.
4. Gut and seed database
5. Add padding to bottom, sides(when small)
6. Change text on front page.
7. Alter settings so that undefined does not come up
Done 8. Add guest user default in schema
DONE 9. Force user to enter something into both forms
DonE 10. Add quest with sessions



1. <!-- Configure rank queries so that they exlude any id's of the optionsSeen from the potential options
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
15. 500 char limit on dreams -->, 200 on goals. text below indicated remaining chars


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

