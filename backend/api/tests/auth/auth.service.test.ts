import {describe, expect, test} from '@jest/globals';
import AuthService from "../../src/modules/auth/auth.service";

const authService = new AuthService();

test("register a new user in the database", async () => {
    const data = {
        username:"test_username",
        first_name:"Testing First Name",
        last_name:"Testing last name",
        email:"Test_email@testdomain.test",
        password:"Test password 123"
    };

    const resp = await authService.register(data);
    const expected_outcome = {
        username:"test_username",
        first_name:"Testing First Name",
        last_name:"Testing last name",
        email:"Test_email@testdomain.test",
        is_active:true
    }
    expect(resp).toMatchObject(expected_outcome)
    expect(resp.id).toEqual(expect.any(String));
})