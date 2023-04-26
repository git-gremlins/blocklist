# blocklist

Name: **blocklist**

## User stories

### MVP

- Users should be able to make accounts/sign in with google
- Users should be able to create tasks
  - Users should be able to prioritise tasks^[Or we can have it where the
    task gets bigger and bigger as the deadline approaches.]
- User should be able to create categories/tags
- Task should have tags
- User tasks should be tracked by the backend so that the user can access them
  on any device
- Infinite zoom
  [here](https://www.npmjs.com/package/@openspacelabs/react-native-zoomable-view) 

### Extended

- Users can choose theme colours
- Users can assign shapes of sub tasks
- Potential for expansion for calendaring/scheduling
- Different mosaic block classes

## Stack

> All using typescript

- Frontend:
  - React native: for creating a native mobile app
  - expo: react native's equivalent of next
  - clerk-expo: for authentication,
  - [styling](https://www.nativewind.dev): nativewind. Tailwind for react native
- Backend:
  - tRPC: typescript centric server implementation using zod for typesafe
    server. Keeps type homogeneity with front and backend
  - postgress
  - prisma: ORM to abstract away raw sql and define table schema

## RATs

- Prisma implementation
- tRPC routing and type definitions with `zod`
- Tap to zoom
- Lazy rendering on infinite scroll
  (https://medium.com/swlh/lazy-loading-with-react-native-62cfe03986a4)
