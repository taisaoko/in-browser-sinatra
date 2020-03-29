# here is where I will create some seed data to work with and test associations

# Create 2 users
howard = User.create(name: "Howard", email: "howard@howard.com", password: "password")
sherry = User.create(name: "Sherry", email: "sherry@sherry.com", password: "password")

# Create some journal entries

JournalEntry.create(content: "Today is Tuesday and it's great!", user_id: howard.id)

# Use AR to pre-associate data

howard.journal_entries.create(content: "We are build a Sinatra app!")
sherrys_entry = sherry.journal_entries.build(content: "It's super cold in VA")
sherrys_entry.save