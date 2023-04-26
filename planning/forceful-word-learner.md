# 

Name: ****

## User stories

### MVP

- User should be able to create account and all data linked to user
- User should specify words that they want to learn in the app
- Difficult to dismiss screen overlay asks for the input of the words and then
  tells you if you got them right or wrong
- Tells the user the definition if the words are wrong for the next popup
- User gratification; streak; path (gamification)

### Extended

- Word pools
- Archiving words that the user has learnt
- Keeping track of progress
- DnDisturb mode

## Stack

> All using typescript

- Frontend: React native, expo, clerk-expo for authentication,
  [styling](https://www.nativewind.dev)
- Backend: tRPC, prisma, postgress

## RATs

- Prisma implementation
- tRPC routing and type definitions with `zod`
- Whole screen popup on the mobile telephone???
