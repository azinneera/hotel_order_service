import ballerina/http;
import ballerina/graphql;

final http:Client orderServiceClient = check new("http://localhost:9092");
final graphql:Client menuServiceClient = check new ("localhost:9093/ms");

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /app on new http:Listener(9090) {

    isolated resource function get orders/menus() returns MenuItem[]|error {
        MenuItemResponse res = check menuServiceClient->execute("query { menus { id item price isAvailableNow} }");
        return res.data.menus;
    }

    isolated resource function get orders() returns Order[]|error {
        return orderServiceClient->get("/sales/orders/");
    }

    isolated resource function get orders/[string orderId]() returns Order|error {
        return orderServiceClient->get("/sales/orders/" + orderId);
    }

    isolated resource function post orders(Order orderRequest) returns Order|error {
        return orderServiceClient->post("/sales/orders/", orderRequest);
    }
}

enum MenuIds {
    M1 = "M1",
    M2 = "M2",
    M3 = "M3",
    M4 = "M4",
    M5 = "M5"
};

type Order record {|
    readonly string id;
    string customerId;
    MenuIds[] itemIds;
    string date;
    float totalPrice;
|};

type MenuItem record {|
    readonly string id;
    string item;
    float price;
    boolean isAvailableNow;
|};

type MenuItemResponse record {|
    record {| MenuItem[] menus; |} data;
|};
