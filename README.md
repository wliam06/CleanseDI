# CleanseDI

More detail what is [Cleanse](https://github.com/square/Cleanse)

## Terminology
### Components and subcomponents
Your object will start with a `RootComponent` and `Component` represent an object graph that used to inject object.

### Modules
Modules are the building blocks for components (one object graph). They are the way to define how the dependencies are going to be instantiated.

### Scopes
Scopes are the way to define the lifecycle of dependencies. Cleanse provides two scopes:
 - Singleton
 Used to tell the binder that you want it to use the same instance when providing the dependency.

 - Unscoped
 Used to a new instance will be instantiated every time.

 ### Binder
 module configuration use to configure their providers. There are 2 core methods: 
  - Simpler one (One passes it an instance of a module to be installed)
  ```
  binder.include(module: PrimaryAPIURLModule.self)
  ```

  - Argument Binding(takes one argument)
  ```
  bind<E>(type: E.Type)
  ```

  > `bind()` returns a `BindingBuilder` that one must call methods on to complete the configuration of the binding that was instantiated.


 ### Type Tags
 Tags are a way to provide named parameters to our objects. Use `Tag` to tag object type.

 ```
 public struct PrimaryAPIURL : Tag {
    typealias Element = NSURL
}

TaggedProvider<PrimaryAPIURL>
```

### Property Injection
The way have to provide dependencies to an object after its instantiation. This particularly useful when the system instantiates the object such as `AppDelegate`, `Scene Delegate`.

### Assisted Injection
A technique where provide additional objects to object instantiation that are not part of the graph. Use this, when combining seeded parameters.

```
extension CustomerDetailViewController {
    // Factory
    struct Seed: AssistedFactory {
        typealias Seed = String
        typealias Element = CustomerDetailViewController
    }

    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder
              .bindFactory(CustomerDetailViewController.self)
              .with(AssistedFactory.self) // Assisted Injection
              .to(factory: CustomerDetailViewController.init)
        }
    }
}
```

### Multibindings / Collection Bindings
Simple concept where the object you provides are put into an array or collection.