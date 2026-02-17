# ums

A new Flutter project.

## Section 2
--Explain how you handled data integrity (e.g., unique constraints, indexes for performance)
--Discuss potential security measures taken:
    --Lke password hashing
    --Rate limiting, and 
    --Handling token expiration


--Answers:
    -- I handled data integrity by ensuring that the user field such as the email, and username are unique. So at the database level in the node, I made sure I used primary key to index every individual created. This ensure that every created data is indexed.

    -- Security measures that I took included using bcrypt to hash the password, making it difficult for an individual to read. The bcrypt ensures that passwords are not stored in plain text. During user login, the user entered password is also compared with existing hashed password using the same bcrypt.

    -- I did not integrate Rate limiting in my backend. But that can be achieved by ensuring that api's are not abused. This can be achieved by checking the number of times a certain IP address hits a particular api and block it, should the attacker try to do a DDOS attack or other forms of online attacks.

    -- I used jsonwebtoken authentication with expiration times defined in the token payload. The access token is given a maximum of 10 minutes. I made it such that if the system is a banking app or a fintec application, I believe users are there to perform a specific task so limiting the token will encourage them to fasten their process when using the app.

