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

    isolated resource function get orders/menus() returns MenuItem[]|http:InternalServerError {
        MenuItemResponse|error res = menuServiceClient->execute("query { menus { id item price isAvailableNow} }");

        if res is error {
            return http:INTERNAL_SERVER_ERROR;
        }
        return res.data.menus;
    }

    isolated resource function get orders() returns Order[]|http:InternalServerError {
        Order[]|error res = orderServiceClient->get("/sales/orders/");

        if res is error {
            return http:INTERNAL_SERVER_ERROR;
        }
        return res;
    }

    isolated resource function get orders/[string orderId]() returns Order|http:InternalServerError|http:ApplicationResponseError {
        Order|http:ClientError res = orderServiceClient->get("/sales/orders/" + orderId);

        if res is http:ApplicationResponseError {
            return res;
        }
        if res is http:ClientError {
            return http:INTERNAL_SERVER_ERROR;
        }
        return res;
    }

    isolated resource function post orders(Order orderRequest) returns Order|http:InternalServerError|http:ApplicationResponseError {
        Order|http:ClientError res = orderServiceClient->post("/sales/orders/", orderRequest, targetType = Order);
        
        if res is http:ApplicationResponseError {
            return res;
        }
        if res is http:ClientError {
            return http:INTERNAL_SERVER_ERROR;
        }
        return res;
    }
}
