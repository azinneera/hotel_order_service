import ballerina/http;

table<Order> key(id) orders = table [
    {id: "O-274", customerId: "C123", totalPrice: 50.25, date: "2024-9-5", itemIds: ["M1", "M2", "M3"]},
    {id: "O-145", customerId: "C124", totalPrice: 35.50, date: "2024-9-5", itemIds: ["M4", "M5"]},
    {id: "O-321", customerId: "C125", totalPrice: 75.00, date: "2024-9-5", itemIds: ["M2", "M3", "M4"]}
];

service /sales on new http:Listener(9092) {

    // GET http:localhost:9092/sales/orders
    resource function get orders() returns Order[] {
        return orders.toArray();
    };

    // GET http:localhost:9092/sales/orders/<Order-ID>
    resource function get orders/[string id]() returns Order|http:NotFound {
        if orders.hasKey(id) {
            return orders.get(id);
        }
        return {body: string `Order not found for id: ${id}`};
    };

    // POST http:localhost:9092/sales/orders
    resource function post orders(Order orderRequest) returns Order|http:BadRequest {
        if orders.hasKey(orderRequest.id) {
            return {body: string `invalid order found`};
        }
        orders.add(orderRequest);
        return orderRequest;
    }
}

type Order record {
    readonly string id;
    string customerId;
    MenuIds[] itemIds;
    string date;
    float totalPrice;
};

enum MenuIds {
    M1 = "M1",
    M2 = "M2",
    M3 = "M3",
    M4 = "M4",
    M5 = "M5"
};
