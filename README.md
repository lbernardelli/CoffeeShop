## Overview

This project demonstrates a **production-quality Ruby application** built following industry best practices including **SOLID principles**, **Clean Architecture**, **Hexagonal Design**, and comprehensive **Test-Driven Development**.

The application manages a coffee ordering system that tracks user orders, payments, and balances with precise monetary calculations using BigDecimal for financial accuracy.

## Architecture Highlights

### Clean Architecture & Hexagonal Design

The codebase is structured in layers with clear separation of concerns:

```
lib/coffee_app/
├── models/              # Domain entities (User, Order, Coffee, OrderItem, Payment, CoffeeVariant)
├── value_objects/       # Immutable value objects (Money)
├── services/            # Application services (OrderService, PaymentService)
├── repositories/        # Data access layer (UserRepository)
├── factories/           # Object creation (CoffeeFactory)
├── presenters/          # Presentation logic (UserPresenter)
├── serializers/         # Output formatting (ResultSerializer)
├── utils/               # Infrastructure (JsonParser)
└── errors/              # Custom exceptions (ValidationError, ParseError)
```

**Key Architectural Decisions:**

1. **Domain Layer Purity**: Models contain only business logic, no serialization or infrastructure concerns
2. **Dependency Inversion**: Services depend on abstractions (repositories), not concrete implementations
3. **Single Responsibility**: Each class has one clear reason to change
4. **Separation of Concerns**: Presentation logic isolated from domain logic

### SOLID Principles Implementation

#### ✅ Single Responsibility Principle (SRP)
- **UserPresenter**: Handles only view formatting
- **OrderService**: Processes orders workflow
- **PaymentService**: Manages payments workflow
- **UserRepository**: Data access only
- **Money**: Value object for monetary calculations

#### ✅ Open/Closed Principle (OCP)
- **Money value object**: Extensible for new operations without modifying existing code
- **Validation system**: Custom errors allow extension without changing core models

#### ✅ Liskov Substitution Principle (LSP)
- All value objects are properly comparable and substitutable
- Services implement consistent interfaces

#### ✅ Interface Segregation Principle (ISP)
- Small, focused interfaces (e.g., UserRepository provides only necessary methods)
- No fat interfaces forcing clients to depend on unused methods

#### ✅ Dependency Inversion Principle (DIP)
- **OrderManager** depends on service abstractions, not implementations
- Services receive dependencies via constructor injection
- No direct coupling to infrastructure details

## Design Patterns Applied

### 1. **Value Object Pattern** (`Money`)
```ruby
class Money
  include Comparable

  def +(other)
    Money.new(@amount + other.amount)
  end

  def -(other)
    Money.new(@amount - other.amount)
  end

  # Arithmetic operations return new instances (immutability)
end
```

**Benefits:**
- Encapsulates monetary operations
- Prevents primitive obsession
- Type-safe arithmetic
- Precise BigDecimal calculations

### 2. **Repository Pattern** (`UserRepository`)
```ruby
class UserRepository
  def find_or_create(user_name)
    @users[user_name.to_sym] ||= User.new(name: user_name)
  end

  def save(user)
    @users[user.name.to_sym] = user
  end
end
```

**Benefits:**
- Abstracts data persistence
- Testable without database
- Easy to swap implementations

### 3. **Service Object Pattern** (`OrderService`, `PaymentService`)
```ruby
class OrderService
  def initialize(products, user_repository)
    @products = products
    @user_repository = user_repository
  end

  def process_orders(orders_data)
    # Orchestrates order processing workflow
  end
end
```

**Benefits:**
- Encapsulates complex business workflows
- Clear transaction boundaries
- Easy to test in isolation

### 4. **Factory Pattern** (`CoffeeFactory`)
```ruby
class CoffeeFactory
  def build
    @prices.each do |item|
      coffee = Coffee.new(name: item[:drink_name])
      item[:prices].each do |price|
        coffee.add_size(CoffeeVariant.new(size: price[0], price: price[1]))
      end
      @coffees[coffee.name.to_sym] = coffee
    end
    @coffees
  end
end
```

**Benefits:**
- Centralizes object creation logic
- Handles complex initialization
- Separates construction from use

### 5. **Presenter Pattern** (`UserPresenter`)
```ruby
class UserPresenter
  def to_hash
    {
      user: @user.name,
      order_total: @user.total_ordered.to_f,
      payment_total: @user.total_paid.to_f,
      balance: @user.balance.to_f
    }
  end
end
```

**Benefits:**
- Separates presentation from domain logic
- Keeps models pure
- Easy to change output format

### 6. **Facade Pattern** (`OrderManager`)
```ruby
class OrderManager
  def initialize(products)
    @user_repository = Repositories::UserRepository.new
    @order_service = Services::OrderService.new(products, @user_repository)
    @payment_service = Services::PaymentService.new(@user_repository)
  end

  def process_all(orders)
    @order_service.process_orders(orders)
    self
  end
end
```

**Benefits:**
- Simplifies complex subsystem interactions
- Provides unified interface
- Reduces coupling

## Code Quality & Best Practices

### Error Handling Strategy

**Custom Exception Hierarchy:**
```ruby
module Errors
  class ValidationError < StandardError
    attr_reader :field, :value

    def initialize(message, field: nil, value: nil)
      @field = field
      @value = value
      super(message)
    end
  end

  class ParseError < StandardError
    attr_reader :original_error, :input

    def initialize(message, original_error: nil, input: nil)
      @original_error = original_error
      @input = input
      super(message)
    end
  end
end
```

**Fail Fast Validation:**
- All domain entities validate input on construction
- Rich error context (field, value, original error)
- Prevents invalid state propagation

### Input Validation

All domain boundaries are protected:

```ruby
# Money validates nil and invalid amounts
# User validates empty names
# Payment prevents negative amounts
# OrderItem validates nil products/variants
# Coffee validates empty names
# CoffeeVariant validates empty sizes and non-positive prices
```

### Comprehensive Test Coverage

**16 Test Suites** covering:

- **Unit Tests**: All models, value objects, services, repositories
- **Integration Tests**: End-to-end workflows
- **Validation Tests**: All edge cases and error conditions
- **Behavioral Tests**: Business logic verification

```bash
bundle exec rspec
# 100+ test cases across all layers
```

### Ruby Best Practices

1. **Frozen String Literals**: All files use `# frozen_string_literal: true`
2. **Method Chaining**: Builder methods return `self` for fluent interfaces
3. **Inject Pattern**: Proper use of `inject` for collection operations
4. **Symbol Keys**: Consistent use for hash lookups
5. **Guard Clauses**: Validation at method entry points
6. **Explicit Returns**: Clear about what methods return

## Technical Decisions & Trade-offs

### 1. **BigDecimal for Money**
- **Why**: Precise financial calculations, avoids floating-point errors
- **Trade-off**: Slightly slower than floats, but correctness > performance

### 2. **In-Memory Repository**
- **Why**: Simplicity for this scope, easy to test
- **Trade-off**: Data not persisted, but demonstrates repository pattern

### 3. **Symbol-based Keys**
- **Why**: Ruby idiomatic for hash lookups, memory efficient
- **Trade-off**: Could use string keys for consistency

### 4. **No External Dependencies**
- **Why**: Showcase pure Ruby skills, minimize setup complexity
- **Trade-off**: No ActiveSupport conveniences, but demonstrates core Ruby proficiency

### 5. **Fail-Fast Validation**
- **Why**: Prevent invalid state, easier debugging, clear error messages
- **Trade-off**: Less forgiving to input errors, but better for production systems

### 6. **Builder Pattern Return Self**
- **Why**: Enables method chaining for fluent API
- **Example**: `user.add_order(order).pay(10.00)`

## Running the Application

### Install Dependencies
```bash
bundle install
```

### Run Application
```bash
bundle exec rake
```

### Run Tests
```bash
bundle exec rspec
```

### Run Specific Test
```bash
bundle exec rspec spec/models/user_spec.rb
bundle exec rspec spec/value_objects/money_spec.rb
```

## Project Structure

```
.
├── lib/
│   └── coffee_app/
│       ├── models/           # Domain entities
│       ├── value_objects/    # Value objects (Money)
│       ├── services/         # Application services
│       ├── repositories/     # Data access
│       ├── factories/        # Object factories
│       ├── presenters/       # View logic
│       ├── serializers/      # Output formatting
│       ├── utils/            # Infrastructure
│       └── errors/           # Custom exceptions
├── spec/                     # Comprehensive test suite
├── data/                     # JSON input files
└── README.md                 # This file
```

- I assumed that when I pay more than I ordered I have a credit and this credit will be exposed as negative. This decision was made because the integration spec was defined to put on positive all value that user owes.
- I did not use other gems because I wanted to show all my code here.
- I decided to not use error handling and expect a Character as amount because I assumed that it's not a useful use case to show here (I'm not saying that error handle is not important, contrariwise).
- I did not worry about performance here.
- When I used rubocop to grant ruby code conventions I did not change all code existent here, I skipped rake class purposely. 

## Background

We like coffee.

So we built an app to fetch coffee for people from our favourite barista.

The app keeps track of coffee ordered; what the balance is for each user; what users have paid for already; and what is still owed.

## Data

We've got the following data

- `data/prices.json` - provided by our barista. Has details of what beverages are available, and what their prices are.
- `data/orders.json` - list of beverages ordered by users of the app.
- `data/payments.json` - list of payments made by users paying for items they have purchased.

## Requirements

- Load the list of prices
- Load the orders
  - Calculate the total cost of each user's orders
- Load the payments
  - Calculate the total payment for each user
  - Calculate what each user now owes
- Return a JSON string containing the results of this work.

(see `spec/coffee_app_integration_spec.rb` for specific examples)
