export type UserCreateInput = {
  name: string;
  surname: string;
  settings?: {} | any;
};
const users: UserCreateInput[] = [
  {
    name: "John",
    surname: "Doe",
    settings: {},
  },
  {
    name: "Jane",
    surname: "Doe",
    settings: {},
  },
  {
    name: "Bob",
    surname: "Smith",
    settings: {},
  },
];

export default users;
