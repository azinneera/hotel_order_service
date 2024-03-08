import ballerina/http;
import ballerina/graphql;

http:Client orderServiceClient = check new("http://localhost:9092");
graphql:Client menuServiceClient = check new ("localhost:9093/ms");

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /app on new http:Listener(9090) {

    resource function get orders/menus() returns MenuItem[]|http:InternalServerError {
        MenuItemResponse|error res = menuServiceClient->execute("query { menus { id item price isAvailableNow} }");

        if res is error {
            return http:INTERNAL_SERVER_ERROR;
        }
        return res.data.menus;
    }

    resource function get orders() returns Order[]|http:InternalServerError {
        Order[]|error res = orderServiceClient->get("/sales/orders/");

        if res is error {
            return http:INTERNAL_SERVER_ERROR;
        }
        return res;
    }

    resource function get orders/[string orderId]() returns Order|http:InternalServerError|http:ApplicationResponseError {
        do {
            return check orderServiceClient->get("/sales/orders/" + orderId, targetType = Order);
        } on fail error e {
            if e is http:ApplicationResponseError {
                return e;
            }
            return http:INTERNAL_SERVER_ERROR;
        }
    }

    resource function post orders(Order orderRequest) returns Order|http:InternalServerError|http:ApplicationResponseError {
        do {
            return check orderServiceClient->post("/sales/orders/", orderRequest, targetType = Order);
        } on fail error e {
            if e is http:ApplicationResponseError {
                return e;
            }
            return http:INTERNAL_SERVER_ERROR;
        }
    }
}
