# FCFun

A sample project showing how you can use [FCModel](https://github.com/marcoarment/FCModel) to create a simple OSX app.

## Setup

This project uses [Cocoapods](http://cocoapods.org) for it's dependencies.

After you download, install the dependencies and always work on `FCFun.xcworkspace`.

To install the dependencies run:

	pod install

## Cool stuff to check out

`Models/Migrations/FFMigrator.m`
This is the class responsible for the database migrations, it loads the appropriate sql files according to the current database version and runs them to update the schema. It's migration method is called from `AppDelegate`.

`Models/Base/GRDatedModel.[h|m]`
A simple FCModel subclass to automatically provide createdAt and updatedAt attributes.

`Data Sources/` Classes responsible for providing data related to the models. `FFPeopleDataSource` provides an ordered list of people to a `NSTableView`, while `FFRolesDataSource` provides a list of Roles to a `NSComboBox`. These are instantiated from the XIBs.

`Controllers/FFPeopleWindowController.m` The window controller responsible for showing the list of people, deleting people and showing the "Add Person" panel.

`Controllers/FFAddPersonWindowController.m` The "Add Person" window.