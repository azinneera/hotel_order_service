import ballerina/graphql;

type MenuItem record {
    readonly string id;
    string item;
    float price;
    boolean isAvailableNow;
};

@graphql:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /ms on new graphql:Listener(9093) {
    resource function get menus(string? id) returns MenuItem[] {
        if id is () {
            return menuItems.toArray();
        }
        return from MenuItem entry in menuItems
            where entry.id == id
            select entry;
    }
}
