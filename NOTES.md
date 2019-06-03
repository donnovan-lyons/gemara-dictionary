Todo list
1. Complete views.
2. Review flash messages.
3. Implement when creating new tables words for user don't exist in other tables.
4. Fix the Nav bar.
5. Final CSS editing after all of this is complete.

Sinatra Project Checklist of Requirements

1. Try to create a skeleton repository on Github
CHECK!

2. What is the purpose of ActiveRecord?

3. What models and associations will you have and why?
I will have Users, Tractates, Tables, and Words. A user will have many tables. A table will have many words. A user will have many words through tables. A tractate will have many tables. A table will belong to a tractate. A tractate will have many users through tables, and a user will have many tractates through tables. A word belongs to a table. CHECK!

4. What validations will you use on your models?
validates_presence_of :username, :password, :password_confirmation CHECK!
validates_uniqueness_of :username CHECK!
validates_confirmation_of :password CHECK!

5. How will you implement an authentication system?

6. Who should be able to edit and destroy a model?
A user should be able to edit only his tables. Anyone can view a tractate's users.

7. What will you need to implement to have your application considered a CRUD app?
Signup to create new users. A delete account, and update password/username option for a user.
Tables can be created, read, updated, and deleted.
A word can be created, read, updated, and deleted.
A tractate can only be updated.
