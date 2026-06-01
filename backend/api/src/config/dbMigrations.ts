import { SequelizeStorage, Umzug } from "umzug";
import sequelize from "./database";

(async() => {
    const migrator = new Umzug({
        migrations: { glob: 'src/database/migrations/*.ts' },
        context: sequelize.getQueryInterface(),
        storage: new SequelizeStorage({ sequelize }),
        logger: console,
    });

    await migrator.up();
})();