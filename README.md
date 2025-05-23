
![RSpec](https://github.com/sviatoslav-krupa/gojilabs-test-task/actions/workflows/rspec.yml/badge.svg?branch=main&label=RSpec)
![Rubocop](https://github.com/sviatoslav-krupa/gojilabs-test-task/actions/workflows/rubocop.yml/badge.svg?branch=main&label=Rubocop)

# What's done
1. Designed database
2. Added needed models with described relationships and validations
3. Added needed controllers and actions:
    3.1.  for enrolling/deleting enrollment fot students
    3.2.  for downloading a PDF file with a schedule for students
5. Add unit tests (RSpec) for models, controllers, routes and services
6. Add CI for RSpec and Rubocop
7. Recorded a demo with builded functionality

# Notes
1. CRUD actions are missing (generating records from seeds or directly through DB/Rails console)
2. For PDF generation, Prawn is used

# Demo
https://drive.google.com/file/d/172OVhs_AgP3rwMWNDeDyzXzUQBfYubXz/view?usp=share_link
