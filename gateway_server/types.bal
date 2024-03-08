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
