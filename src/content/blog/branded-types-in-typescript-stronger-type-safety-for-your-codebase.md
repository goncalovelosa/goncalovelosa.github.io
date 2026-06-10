---
title: "Branded Types in TypeScript: Stronger Type Safety for Your Codebase"
description: "TypeScript is fantastic for catching type-related errors at compile time. However, there are scenarios where its structural type system falls short. This is where branded types step in."
pubDate: 2024-06-12
category: "TypeScript"
tags: ["typescript", "type-safety", "branded-types", "nominal-typing"]
mediumUrl: "https://medium.com/@gvelosa/branded-types-in-typescript-stronger-type-safety-for-your-codebase-3f2125c28b43"
canonicalUrl: "https://medium.com/@gvelosa/branded-types-in-typescript-stronger-type-safety-for-your-codebase-3f2125c28b43"
---

TypeScript is fantastic for catching type-related errors at compile time. However, there are scenarios where its structural type system falls short. This is where branded types step in, adding an extra layer of type safety and clarity to your code.

## The Problem: TypeScript's Structural Limitations

Let's imagine a scenario where you have an application dealing with user IDs, order IDs, and product IDs. They're all represented as numbers in TypeScript:

```typescript
const userId = 12345;
const orderId = 67890;
const productId = 98765;
```

Oops! You can easily mix these up, and TypeScript won't complain because they share the same structure (they're all numbers). This could lead to subtle bugs in your application.

## Enter Branded Types

Branded types solve this issue by adding a nominal aspect to TypeScript's structural typing. Think of it as giving types a unique "brand" or "tag" to distinguish them, even if their structure is identical.

Here's how you create a branded type in TypeScript:

```typescript
type UserId = number & { readonly __brand: unique symbol };
type OrderId = number & { readonly __brand: unique symbol };
type ProductId = number & { readonly __brand: unique symbol };
```

The `__brand` property is a symbol that acts as the unique identifier for each type. Now, even though `UserId`, `OrderId`, and `ProductId` are all numbers under the hood, TypeScript treats them as distinct types.

## Improved Runtime Type Safety

Branded types not only improve compile-time type checking but also enhance runtime safety. Here's a simple example:

```typescript
function processOrder(orderId: OrderId) {
  // ...
}

const userId: UserId = 12345 as UserId;
processOrder(userId); // Compile-time error!
```

TypeScript will raise a flag during compilation, since you're trying to pass a `UserId` where an `OrderId` is expected.

## Advantages of Branded Types

- **Clarity:** Your code becomes more self-documenting. Variable names like `userId` clearly convey their purpose.
- **Safety:** Catching errors early prevents potential runtime issues.
- **Refactoring Confidence:** When you change the underlying type of a branded type (e.g., from `number` to `string`), the compiler helps you identify all affected areas.

## Disadvantages of Branded Types

- **Verbosity:** Defining and using branded types adds some boilerplate to your code.
- **Library Compatibility:** Not all third-party libraries may be designed to work seamlessly with branded types.

## Why Branded Types Are Useful

Branded types shine in these situations:

- **IDs and Identifiers:** Distinguishing between different types of IDs (user, product, order, etc.).
- **Units of Measurement:** Preventing errors like adding meters and kilograms.
- **Domain-Specific Types:** Creating more expressive types for your business logic (e.g., `EmailAddress`, `PhoneNumber`).
- **Interoperability with JavaScript:** While TypeScript enforces branded types, they don't affect runtime behaviour, making your code compatible with plain JavaScript.

## Conclusion

Branded types are a powerful tool in your TypeScript arsenal. While they might introduce some initial overhead, they significantly improve type safety, making your code more reliable and maintainable. Consider using them whenever you have structurally similar types that represent distinct concepts.
