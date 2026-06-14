import crypto from "crypto";
import bcrypt from "bcrypt";
import Token, { TokenType } from "./token.model";

export default class TokenService {
    private generateToken(){
        //Generates 64-byte token
        return crypto.randomBytes(64).toString("hex");
    }

    async hashToken(token_str: string){
        return await bcrypt.hash(token_str, 10);
    }

    async useToken(token: Token): Promise<Token>{
        token.used_at = new Date();
        await token.save();
        return token;
    }

    async revokeToken(token: Token): Promise<Token>{
        token.revoked_at = new Date();
        await token.save();
        return token;
    }

    async revokeAllUserTokens(user_id: string, tokenType: TokenType): Promise<void>{
        await Token.update({
            revoked_at: new Date()
        }, {
            where:{
                user_id,
                token_type: tokenType
            }
        });
    }

    async createToken(userId: string, type: TokenType): Promise<string>{
        const token_str = this.generateToken();
        const token_hash =  await this.hashToken(token_str);

        const token = await Token.create({
            token_hash: token_hash,
            token_type: type,
            user_id: userId,
            expires_at: new Date(
                Date.now() + (30 * 24 * 60 * 60 * 1000)
            )
        })

        return `${token.id}.${token_str}`;
    }

    async validateToken(tokenId: string, token_str: string, required_type: TokenType): Promise<Token | null>{
        const token = await Token.findOne({
            where: {
                id: tokenId,
                token_type: required_type
            }
        });

        if (!token) {
            return null;
        }

        const valid = await bcrypt.compare(
            token_str,
            token.token_hash
        );

        if (!valid) return null;

        if (token.revoked_at) return null;

        if (token.used_at) return null;

        if (token.expires_at < new Date()) return null;

        return token;
    }
}