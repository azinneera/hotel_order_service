import ballerina/http;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /sales on new http:Listener(9092) {
    resource function get orders() returns Order[] {
        return orders.toArray();
    };

    resource function get orders/[string id]() returns Order|http:NotFound {
        if orders.hasKey(id) {
            return orders.get(id);
        }
        return { body: string `Order not found. Order ID: ${id}` };
    };

    resource function post orders(Order orderRequest) returns Order|http:BadRequest {
        if orders.hasKey(orderRequest.id) {
            return { body: string `Order id already exists. Order ID: ${orderRequest.id}` };
        }
        orders.add(orderRequest);
        return orderRequest;
    }
}

type Order record {|
    readonly string id;
    string customerId;
    MenuIds[] itemIds;
    string date;
    float totalPrice;
|};

enum MenuIds {
    M1 = "M-1",
    M2 = "M-2",
    M3 = "M-3",
    M4 = "M-4",
    M5 = "M-5",
    M6 = "M-6",
    M7 = "M-7",
    M8 = "M-8",
    M9 = "M-9",
    M10 = "M-10"
};
