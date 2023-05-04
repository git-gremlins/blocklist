export type UserCreateInput = {
  userId: string;
  name: string;
  surname: string;
  settings?: {} | any;
};
const users: UserCreateInput[] = [
  {
    userId: "1",
    name: "John",
    surname: "Doe",
    settings: {},
  },
  {
    userId: "2",
    name: "Jane",
    surname: "Doe",
    settings: {},
  },
  {
    userId: "3",
    name: "Bob",
    surname: "Smith",
    settings: {},
  },
];

export default users;
