const { Connection, Request } = require('tedious');

module.exports = async function (context, req) {
    context.log('Processing registration request...');

    // 1. إعدادات الاتصال (بدون باسورد - Managed Identity)
    const config = {
        server: 'your-server-name.database.windows.net', // استبدله باسم سيرفرك
        authentication: {
            type: 'azure-active-directory-msi-vm' 
        },
        options: {
            database: 'your-db-name', // استبدله باسم قاعدتك
            encrypt: true,
            port: 1433
        }
    };

    return new Promise((resolve, reject) => {
        const connection = new Connection(config);

        connection.on('connect', (err) => {
            if (err) {
                context.log.error('Connection Failed:', err);
                context.res = { status: 500, body: "Error connecting to database" };
                resolve();
            } else {
                // 2. أمر إدخال البيانات (SQL Insert)
                const { orgName, email } = req.body;
                const query = `INSERT INTO Customers (OrganizationName, PrimaryContactEmail) 
                               VALUES ('${orgName}', '${email}')`;

                const request = new Request(query, (err) => {
                    if (err) {
                        context.res = { status: 500, body: "Error saving data" };
                    } else {
                        context.res = { status: 200, body: "Customer Registered Successfully!" };
                    }
                    connection.close();
                    resolve();
                });
                connection.execSql(request);
            }
        });

        connection.connect();
    });
};