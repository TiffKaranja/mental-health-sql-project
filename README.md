# Mental Health SQL Project

This is a simple SQL project I worked on to model a mental health clinic's data system. It includes tables for patients, doctors, and visits. I also wrote several queries to explore and analyze the data — things like finding patients who had follow-up visits, matching doctors with specializations, and checking how many times each patient has visited.

## What’s Inside

- **mental_health_patients**: stores patient info like name, age, gender, diagnosis, etc.
- **mental_health_doctors**: stores doctors' names and their specialties
- **mental_health_visits**: connects patients to doctors and keeps track of visit details

## What I Did

- Created the database structure using PostgreSQL
- Inserted sample data (patients, doctors, and visits)
- Wrote a bunch of SQL queries to answer different questions using joins, subqueries, and aggregations

Some examples:
- Show all patients and the doctors they've seen (even if they haven't seen any)
- Find patients who visited more than 2 doctors
- Get the average age of patients who’ve visited a psychiatrist
- List all visits and match them with patients and doctors