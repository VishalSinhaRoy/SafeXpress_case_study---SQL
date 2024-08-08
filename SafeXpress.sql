-- Create the Clients table
CREATE TABLE Clients (
    Client_id SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact_details VARCHAR(255),
    Agreements_if_any TEXT
);

-- Create the Orders table
CREATE TABLE Orders (
    Order_id SERIAL PRIMARY KEY,
    Client_id INT REFERENCES Clients(Client_id) ON DELETE CASCADE,
    Order_date DATE NOT NULL,
    Status VARCHAR(50)
);

-- Create the Warehouses table
CREATE TABLE Warehouses (
    Warehouse_id SERIAL PRIMARY KEY,
    Location VARCHAR(100) NOT NULL,
    Capacity INT,
    Type VARCHAR(50)
);

-- Create the Inventory table
CREATE TABLE Inventory (
    Item_id SERIAL PRIMARY KEY,
    Warehouse_id INT REFERENCES Warehouses(Warehouse_id) ON DELETE CASCADE,
    Description VARCHAR(255),
    Quantity INT,
    Updates_on_inventory TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Shipments table
CREATE TABLE Shipments (
    Shipment_id SERIAL PRIMARY KEY,
    Order_id INT REFERENCES Orders(Order_id) ON DELETE CASCADE,
    Origin VARCHAR(255),
    Destination VARCHAR(100),
    Current_location VARCHAR(100),
    Status VARCHAR(50)
);

-- Create the WarehouseOrders junction table
CREATE TABLE WarehouseOrders (
    WarehouseOrder_id SERIAL PRIMARY KEY,
    Warehouse_id INT REFERENCES Warehouses(Warehouse_id) ON DELETE CASCADE,
    Order_id INT REFERENCES Orders(Order_id) ON DELETE CASCADE,
    UNIQUE (Warehouse_id, Order_id) -- Enforce unique combinations
);

-- Create the Routes table
CREATE TABLE Routes (
    Route_id SERIAL PRIMARY KEY,
    Shipment_id INT REFERENCES Shipments(Shipment_id) ON DELETE CASCADE UNIQUE,
    Waypoints TEXT,
    Modes TEXT
);

-- Create the Tracking table
CREATE TABLE Tracking (
    Tracking_id SERIAL PRIMARY KEY,
    Shipment_id INT REFERENCES Shipments(Shipment_id) ON DELETE CASCADE,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Location VARCHAR(100),
    Status VARCHAR(50)
);

-- Insert clients
INSERT INTO Clients (Name, Contact_details, Agreements_if_any)
VALUES 
('Acme Corp', 'acme@example.com', 'Standard Agreement'),
('Global Industries', 'global@example.com', 'Premium Agreement'),
('Tech Solutions', 'tech@example.com', NULL),
('Innovative Enterprises', 'innovative@example.com', 'Custom Agreement');

-- Selecting everything from clients table
SELECT * FROM Clients;

-- Insert orders
INSERT INTO Orders (Client_id, Order_date, Status)
VALUES 
(1, '2024-08-08', 'Processing'),
(2, '2024-08-09', 'Shipped'),
(3, '2024-08-10', 'Pending'),
(4, '2024-08-11', 'Completed');

-- Selecting everything from orders table
SELECT * FROM Orders;

-- Insert warehouses
INSERT INTO Warehouses (Location, Capacity, Type)
VALUES 
('New York', 1000, 'General Storage'),
('Los Angeles', 1500, 'Temperature-Controlled'),
('Chicago', 2000, 'General Storage'),
('Houston', 1200, 'General Storage');

-- Selecting everything from warehouses table
SELECT * FROM Warehouses;

-- Insert inventory items
INSERT INTO Inventory (Warehouse_id, Description, Quantity)
VALUES 
(1, 'Widgets', 500),
(2, 'Gadgets', 300),
(3, 'Components', 1500),
(1, 'Equipment', 700),
(2, 'Tools', 400);

-- Selecting everything from inventory table
SELECT * FROM Inventory;

-- Insert shipments
INSERT INTO Shipments (Order_id, Origin, Destination, Current_location, Status)
VALUES 
(1, 'New York', 'Los Angeles', 'In Transit', 'Shipped'),
(2, 'Los Angeles', 'San Francisco', 'In Transit', 'Shipped'),
(3, 'Chicago', 'Dallas', 'In Warehouse', 'Pending'),
(4, 'Houston', 'Miami', 'Delivered', 'Completed');

-- Selecting everything from shipments table
SELECT * FROM Shipments;

-- Insert records into WarehouseOrders
INSERT INTO WarehouseOrders (Warehouse_id, Order_id)
VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- Selecting everything from warehouseorders table
SELECT * FROM WarehouseOrders;

-- Insert routes
INSERT INTO Routes (Shipment_id, Waypoints, Modes)
VALUES 
(1, 'NYC -> LA', 'Air'),
(2, 'LA -> SF', 'Truck'),
(3, 'CHI -> DAL', 'Train'),
(4, 'HOU -> MIA', 'Air');

-- Selecting everything from routes table
SELECT * FROM Routes;

-- Insert tracking records
INSERT INTO Tracking (Shipment_id, Location, Status)
VALUES 
(1, 'Denver', 'In Transit'),
(2, 'Bakersfield', 'In Transit'),
(3, 'St. Louis', 'In Transit'),
(4, 'Miami', 'Delivered'),
(1, 'Phoenix', 'In Transit');

-- Selecting everything from tracking table
SELECT * FROM Tracking;
