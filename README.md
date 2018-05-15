# Membrane
[![Build Status](https://travis-ci.org/RohanPoojary/membrane.svg?branch=master)](https://travis-ci.org/RohanPoojary/membrane)

Membrane provides a wrapper for filtering data with simplicity but also supports
complex queries if necessary.

It filters out list of structs or maps that satisfies the query. The Query is inspired by
Mongo, hence there's a lot of similarities. To learn more please visit our documentation https://hexdocs.pm/membrane/Membrane.html .

# Installation
To install just add the module to your mix file.

    def deps do
      [
        ...
        {:membrane, "~> 0.1.0-rc.0"}
      ]
    end

# Examples
Membrane currently provides a single function named `filter` for filtering the data

    iex> data = [
      %Person{id: 1, name: "Bob", action: "talk", age: 30},
      %Person{id: 3, name: "Helen", action: "talk", age: 30},
      %Dog{id: 1, name: "Rocky",  action: "bark", age: 10},
      %Cat{id: 3, name: "Rocky",  action: "meow", age: 6},
      %Chair{id: 10, age: 3},
      %{id: 1, type: "car", age: 12}
    ]
    
    # The query matches all objects with `id` as 1
    iex> Membrane.filter(data, id: 1)
    [
      %{id: 1, type: "car", age: 12},
      %Dog{id: 1, name: "Rocky",  action: "bark", age: 10},
      %Person{id: 1, name: "Bob", action: "talk", age: 30},
    ]

As you can notice `Membrane.filter` is independent of structs or maps in the data. This is because all structs are just bare maps

It also supports complex queries. Say for the same data.

    # The query matches all objects with `age` greater than 8 and has `action` attribute.
    iex> Membrane.filter(data, age: [gt: 8], action: :exists)
    [
      %Dog{id: 1, name: "Rocky",  action: "bark", age: 10},
      %Person{id: 3, name: "Helen", action: "talk", age: 30},
      %Person{id: 1, name: "Bob", action: "talk", age: 30},
    ]


# Task Lists
  - [x] Logical and Comparision Operations
  - [x] List based Operations
  - [x] Filtering based on existence of an attribute
  - [ ] Not Operation
  - [ ] Comparision between attributes of a struct
  - [ ] Renaming of attribute names ( Final output has to be a list of maps )
  - [ ] Filtering map with query keywords as keys.

# Contributing
Its a new project so please free to contribute. Reporting bugs will also help.

# License
The source code is released under MIT License. Check the [License](https://github.com/RohanPoojary/membrane/blob/master/LICENSE) file for more information
