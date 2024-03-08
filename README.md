# Hotel service

This sample application contains a simple hotel management service that enable users to create and view orders and food menus. The service is implemented using Ballerina and the front-end is implemented using React.
To run the application you need to have install Ballerina. You can download it from [here](https://ballerina.io/downloads/). And also you need to install NPM as well. You can download it from [here](https://www.npmjs.com/get-npm).

## High-level view of the System

![Architecture](highlevel_architecture.png)

## How to run the application

1. First you need to clone the repository using the following command.
```
   https://github.com/SasinduDilshara/hotel_order_service.git
```

2. Then you need to navigate to the `hotel_order_service` directory.

```
    cd hotel_order_service
```

3.There are three services under the `hotel_order_service` directory.

* gateway_server - This is the service that will responsible for connecting front-end application with other microservices.
All the user requests will be passing through this gateway service.
* menu_server - This service contains the API endpoints that related to the food menu of the hotel.
* order_server - This service contains the API endpoints that related to the order management of the hotel.

To start these services, simple navigate to each server directory and run the following command.
```
    bal run
```

4. Then you need to navigate to the `hotel_order_service/webapp` directory and start the frontend application service

```
    npm i
    npm run dev
```