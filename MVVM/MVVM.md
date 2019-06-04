## MVC 

### Model (M)
Model (M) stands for Model and in design architecture Model is used to just represent the data.

### View (V)
View (V) stands for View. View is used to display the data (received from Model or ViewModel). So basically XIB,Storyboard acts as a View.

### Controller (C)
Controller (C) stands for Controller. Controller is mediator between View and Model/ViewModel, it receives structured data form the Model/ViewModel and passes that data to View to display it on screen.

## MVVM 

- Controller class passes data (received from server) to Model class.  
- Model class returns structured data to Controller class.  
- Controller class passes structured data to ViewModel class.  
- ViewModel class performs logic over that data if needed and then sends back that final data to Controller class.  
- Controller class passes final data to View class and finally View class displays that data on the screen.
