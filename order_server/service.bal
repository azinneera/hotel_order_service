import ballerina/http;

table<Order> key(id) orders = table [
    {id: "O-1", customerId: "C-123", totalPrice: 50.25, date: "2024-02-28", itemIds: ["M1", "M2", "M3"]},
    {id: "O-2", customerId: "C-124", totalPrice: 35.50, date: "2024-02-27", itemIds: ["M4", "M5"]},
    {id: "O-3", customerId: "C-125", totalPrice: 75.00, date: "2024-02-26", itemIds: ["M2", "M3", "M4"]}
];

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
    M1 = "M1",
    M2 = "M2",
    M3 = "M3",
    M4 = "M4",
    M5 = "M5"
};
