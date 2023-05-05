export type UserCreateInput = {
  userId: string;
  name: string;
  surname: string;
  settings?: {} | any;
};
const users: UserCreateInput[] = [
  {
    userId: "00000000-0000-0000-0000-000000000000",
    name: "John",
    surname: "Doe",
    settings: {},
  },
];

export default users;
