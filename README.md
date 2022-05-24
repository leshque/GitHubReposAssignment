# ReposAssignment

## Task
Please create a small application, that searches for GitHub repositories and shows them in a
list. On tap on one of the results, the application shows a detail page with all branches of the
selected repository.

### As a user 
* I want to be able to search for GitHub repositories by name 
https://docs.github.com/en/rest/reference/search 
* I want to see the first 10 results in a scrollable, vertical list 
* For each of the repositories in the list, I want to see the branch count as well e.g. repository_name (branch_count branches) The branch count should appear at the same time as the other elements in the list. 
* I should be able to start a new search and to receive new search results Once I tap on a repository in the search results, I want to see a new screen that shows all branch names of the selected repository in a list 

### Acceptance Criteria 
The application uses Swift 
The application does not use any third party framework 
The application uses SOLID principles 
The application can use Combine 
The application should use an architectural pattern such as MVVM, VIPER, MVP etc. The application should have at least one or two unit tests 

## Solution

The project is implemented using VIPER-ish architecture.
There are two Modules:
* `RepoListModule` - providing repo search and rendering the search results
* `BranchListModule` - used to render the branch list for the 

Both types also act as a DI containers, resolving the dependencies of internal entities.
Modules are split into View/Presenter/Interactor layers.

`RepoListPresenterTests` added to showcase mocking and unit-testing.

