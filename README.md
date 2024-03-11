# Hotel service

This sample application contains a simple hotel management service that enable users to create and view orders and food menus. The service is implemented using Ballerina. The front-end is implemented using React.

## Prerequsites

1. Install [Ballerina](https://ballerina.io/downloads/)

2. Install [NPM](https://www.npmjs.com/get-npm)

## High-level view of the System

![Architecture](highlevel_architecture.png)

## How to run the application

1. Clone the repository using the following command.

```bash
   git clone https://github.com/SasinduDilshara/hotel_order_service.git
```

2. NAvigate to `hotel_order_service` directory.

```bash
    cd hotel_order_service
```

3.There are three services under the `hotel_order_service` directory.

* gateway_server - This is the service that will responsible for connecting front-end application with other microservices.
All the user requests will be passing through this gateway service.
* menu_server - This service contains the API endpoints that related to the food menu of the hotel.
* order_server - This service contains the API endpoints that related to the order management of the hotel.

To start these services, simply navigate to each server directory and run the following command.
```bash
    bal run
```

4. Finally, navigate to the `hotel_order_service/webapp` directory and start the frontend application service

```
    npm i
    npm run dev
```
