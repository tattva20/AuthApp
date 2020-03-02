# AuthApp 

AuthApp is a simple example of a login view built in the MVVP architecture that checks against a json user list if the user's 
credentials exist and are valid.

The app also has a simple Field Validator to check out that fields aren't empty and that they have a length of 2 or more 
characters, it can be easily expanded to include more complex validations if required. If the fields are empty or the character's count is less than 2 the button to continue will be disabled, if the credentials are valid a new and empty UIViewController will be pushed. 

TO-DO: 
1. Create a proper screen that is pushed after successful login
2. Make the app capable of creating new users with a signup feature

To use it just clone and build, there are no additional dependencies required. 

AuthApp was built using Xcode 11.3.1 and swift 5
