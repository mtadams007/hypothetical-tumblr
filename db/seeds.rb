User.create(firstname: 'Michael', lastname: 'Adams', email: 'michael@email.com', birthday: '1902-11-21', password:'12345', username:'michael')

User.create(firstname: 'Peter', lastname: 'Rabbit', email: 'peter@email.com', birthday: '1904-3-21', password:'12345', username:'peter')

User.create(firstname: 'Aragorn', lastname: 'Strider', email: 'aragorn@email.com', birthday: '1321-12-29', password:'12345', username:'aragorn')

Post.create(hypothetical: "If you could be completely fluent in five languages which would you choose? (You would forget any language you know now)",user_id: 1, tags: ['Impossible'])
Post.create(hypothetical: "If you could have any technology from a fictional universe, what would you take?",user_id: 1, tags: ['Technology'])
Post.create(hypothetical: "If your partner asked you to drink polyjuice potion, would you be offended?",user_id: 1, tags: ["Relationships"])
Post.create(hypothetical: "If you had to have your arms be twice their current length or your legs be twice their current length. Which would you choose?",user_id: 1, tags: ['Impossible'])
Post.create(hypothetical: "Would you rather never have to sleep or never have to use the bathroom?",user_id: 1, tags: ['WouldYouRather'])
Post.create(hypothetical: "If you had a horn that was the size of a 500ml Coca Cola bottle that was anywhere on your body, where would you place it? It is incredibly strong and durable so no surgery can remove it.",user_id: 1)
Post.create(hypothetical: "If you were paid a million dollars a year to stare at a wall 8 hours a day with three weeks of vacation a year until you retire at age 65 would you do it? If you quit before age 65, they confiscate all the money you earned from the job.",user_id: 1)
Post.create(hypothetical: "If you could only eat one food for the rest of your life, which would you choose?",user_id: 2)
Post.create(hypothetical: "Would you rather wrestle an orc or box a Uruk-hai?",user_id: 3, tags: ["WouldYouRather"])
Post.create(hypothetical: "What is your favorite type of carrot?",user_id: 2)
Post.create(hypothetical: "Would you follow Frodo to Mordor?",user_id: 3)
