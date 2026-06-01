import User from "./user.model";

class UserService {
    async getUserById (id: string){
        return User.findOne({
            where: {id}
        });
    }

    async getUserByUsername (username: string) {
        return User.findOne({
            where:{
                username
            }
        });
    }
}

export default new UserService()