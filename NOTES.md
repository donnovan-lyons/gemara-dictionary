Relationships {

A user has many tables.
A table has many words.
A word belongs to a table
A table belongs to a user.
A user has many words...(through tables?)
A user has many tractates.
a tractate has many users
A tractate has many Tables
a table belongs to a tractate


word has a name, translation_one, translation_two, tractates
user has a name, email, password, tables, words through tables
a table has words, and a tractate
a tractate has Tables}
---------------
Todo list
1. Complete views.
2. Implement flash.
3. Implement delete words and tables.
4. Implement when creating new tables words for user don't exist in other tables.
6. Fix the Nav bar.
7. Final CSS editing after all of this is complete.
