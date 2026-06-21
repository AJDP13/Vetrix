import {expect, test} from "vitest";
import AuthService from "../../src/modules/auth/auth.service";
import sequelize from "../../src/config/database";
import User from "../../src/modules/users/user.model";
import {LoginResponse} from "../../src/modules/auth/auth.types";
import {UserResponse} from "../../src/modules/users/user.types";
import jwt, {JwtPayload} from "jsonwebtoken";

const authService = new AuthService();

const test_user_data = {
    username:"test_username_1",
    first_name:"Testing First Name",
    last_name:"Testing last name",
    email:"Test_email_1@testdomain.test",
    password:"Test password 123"
}

test("register a new user in the database", async () => {

    const resp = await authService.register(test_user_data);
    await User.destroy({
        where:{
            id: resp.id
        },
        force:true
    });

    const {password, ...expected_outcome} = test_user_data;

    expect(resp).toMatchObject(expected_outcome)
    expect(resp.id).toEqual(expect.any(String));
})

test("attempt to register user where username already exists", async () => {
    const user1 = await authService.register(test_user_data); //Register first time
    try {
        await expect(
            authService.register({
                ...test_user_data,
                email: "Test_email_1@testdomain.test2"
            })
        ).rejects.toThrow();

    } finally {
        await User.destroy({
            where: {
                id: user1.id
            },
            force: true
        });
    }
})

test("attempt to register user where email already exists", async () => {
    const user1 = await authService.register(test_user_data); //Register first time
    try {
        await expect(
            authService.register({
                ...test_user_data,
                username: "test_username_2" //changed so doesn;t throw false error
            })
        ).rejects.toThrow();

    } finally {
        await User.destroy({
            where: {
                id: user1.id
            },
            force: true
        });
    }
})

test("attempt to login a valid username + password combo", async () => {
    const user1 = await authService.register(test_user_data); //Register first time
    try {
        const resp = await authService.login({
            username: test_user_data.username,
            password: test_user_data.password
        })

        const {password, ...expected_user_resp} = {
            ...test_user_data,
            is_active:true
        }

        expect(resp.user).toMatchObject(expected_user_resp);

        expect(resp.refresh_token.split(".").length).toBe(2)
        const at = jwt.decode(resp.access_token) as JwtPayload;
        expect(at.sub).toBe(resp.user.id)

    } finally {
        await User.destroy({
            where: {
                id: user1.id
            },
            force: true
        });
    }
})

test("attempt to login an invalid username + password combo", async () => {
    const user1 = await authService.register(test_user_data); //Register first time
    try {

        await expect(
            authService.login({
                username: "invalid_username",
                password: "Incorrect PW"
            })
        ).rejects.toThrow();

    } finally {
        await User.destroy({
            where: {
                id: user1.id
            },
            force: true
        });
    }
})