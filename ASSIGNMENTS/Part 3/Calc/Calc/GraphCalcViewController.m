//
//  GraphCalcViewController.m
//  GraphCalc
//
//  Created by darren cullen on 15/02/2013.
//  Copyright (c) 2013 95674454. All rights reserved.
//

#import "GraphCalcViewController.h"

@interface GraphCalcViewController ()

@property (nonatomic) CGFloat graphScale;
@property (weak, nonatomic) IBOutlet UILabel *expressionLabel;
@property (weak, nonatomic) IBOutlet GraphView *graphView;
@property (nonatomic, strong) CalcModel *calcModel;

- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;

@end

@implementation GraphCalcViewController

//#define DEFAULT_SCALE 100;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    return self;
}

//- (CGFloat)graphScale
//{
//    
//    // Set the scale to the default scale if none already
//    if (!_graphScale) _graphScale = DEFAULT_SCALE;
//    
//    return _graphScale;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.expressionLabel.text = self.descriptionOfExpression;
    self.graphView.delegate = self;
    [self setGraphZoomLevel:16];
}

- (IBAction)zoomIn:(id)sender
{
    [self setGraphZoomLevel:self.graphView.graphScale + 1];
}

- (IBAction)zoomOut:(id)sender
{
    [self setGraphZoomLevel:self.graphView.graphScale - 1];
}

- (double) getValueForYAxisFromValueForXAxis:(GraphView *) graphViewDelegator xAxisValue:(double)value{
    // solve the expression with the value supplied from the view
    NSDictionary *variableSet = @{@"x" : [NSNumber numberWithDouble:value]};
    return [CalcModel evaluateExpression:self.expressionToPlot usingVariableValues:variableSet];
}

- (void) setGraphZoomLevel:(double) zoomLevel
{
    if ((zoomLevel > 68) || (zoomLevel < 0.1)) return;
    self.graphView.graphScale = zoomLevel;
    [self.graphView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

- (void)viewDidUnload {
    //[self setGraphView:nil];
    [self setGraphView:nil];
    [self setExpressionLabel:nil];
    [self setGraphView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
