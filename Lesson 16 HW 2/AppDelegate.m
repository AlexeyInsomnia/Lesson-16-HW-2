//
//  AppDelegate.m
//  Lesson 16 HW 2
//
//  Created by Alex on 28.12.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "AppDelegate.h"
#import "APStudent.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSDateComponents* date;
@property (strong, nonatomic) NSDateComponents* dateForBreakingTimer;
@property (strong, nonatomic) NSDate* currentDate;
@property (strong, nonatomic) NSArray* arrayOfStudents;
//@property (strong, nonatomic) NSMutableDictionary* nameLastNameBDay;
@property (assign, nonatomic) NSTimer* timer;
@property (assign, nonatomic) NSTimer* timerVariant2;
@property (assign, nonatomic) NSInteger timerDealloc;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //pupil
    
    /*
     Ученик.
     
     1. Создайте класс студент у когторого будет проперти dateOfBirth (дата рождения), которая собственно NSDate.
     2. Инициализируйте NSMutableArray и в цикле создайте 30 студентов.
     3. Каждому установите дату рождения. Возраст рандомный от 16 до 50 лет.
     4. В другом цикле пройдитесь по всему массиву и выведите день рождения каждого студента в адекватном формате.
     */
    
    NSMutableArray* allStudents = [[NSMutableArray alloc] init];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    for (int i=0; i<30; i++) {
        APStudent* student = [[APStudent alloc] init];
        
        NSDate* date = [NSDate date];
        
        NSCalendar* calendar = [NSCalendar currentCalendar];
        
        NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:date];
        
        NSInteger birthYear = [components year] - (arc4random() % 35 +16);
        
        student.age = [components year] - birthYear;
        
        [components setDay:arc4random() % 31];
        
        [components setMonth:arc4random() % 12];
        
        [components setYear:birthYear];

        student.dateOfBirth = [calendar dateFromComponents:components];
        
        [allStudents addObject:student];
    }
    
    for (APStudent* student in allStudents) {
        NSLog(@"age is - %ld, date of birth is - %@ ", student.age, [ dateFormatter stringFromDate:student.dateOfBirth]);
    }
    
    //student
    /*
     Студент.
     
     5. Отсортируйте массив студентов по дате рождения, начиная от самого юного.
     6. Используя массивы имен и фамилий (по 5-10 имен и фамилий), каждому студенту установите случайное имя и случайную фамилию.
     7. Выведите отсортированных студентов: Имя, Фамилия, год рождения
     */
    
    NSArray* arrayForSort = [[NSArray alloc] initWithArray:allStudents];
    
    arrayForSort = [arrayForSort sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[obj1 dateOfBirth] compare:[obj2 dateOfBirth]];
    }];
    
    
    NSArray* arrayName = [[NSArray alloc] initWithObjects:@"Vasya",
                          @"Petya",
                          @"John",
                          @"Jeck",
                          @"Stella",
                          @"Victoriya",
                          @"Lidiya",
                          @"Amanda",
                          @"Nartuiop",
                          @"Pirat",
                          nil];
    
    NSArray* arrayLastName = [[NSArray alloc] initWithObjects:@"Ivanoff",
                              @"Petrof",
                              @"Sergeev",
                              @"Hrayjoy",
                              @"Stellofcinkiy",
                              @"Victorianskiy",
                              @"Toporrchenko",
                              @"Stellovatova",
                              @"Kovalenko",
                              @"Petrenko",
                              nil];
    
    
    for (APStudent* newFIO in arrayForSort) {
        newFIO.name = [arrayName objectAtIndex:arc4random() %[arrayName count]];
        
        newFIO.lastName = [arrayLastName objectAtIndex:arc4random() %[arrayLastName count]];
        
        NSLog(@"%@, %@, age is - %ld, date of birth is - %@ ", newFIO.name, newFIO.lastName, newFIO.age, [ dateFormatter stringFromDate:newFIO.dateOfBirth]);
    }
    
    // master
    // 1st lets count older - younger
    /*
     12. Выведите на экран разницу в возрасте между самым молодым и самым старым студентом (количество лет, месяцев, недель и дней)
     */
    
    
    APStudent* oldest = [arrayForSort firstObject];
    
    APStudent* youngling = [arrayForSort lastObject];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* olderForDate = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay fromDate:oldest.dateOfBirth toDate:youngling.dateOfBirth options:0];
    
    NSLog(@"oldest is older for %ld years %ld months %ld weeks %ld days", olderForDate.year, olderForDate.month, olderForDate.weekOfMonth, olderForDate.day);
    
    // now is a bit challenge for me, intervals.ok. lets test.
    
    // was hard , so lets make it in 2 variants.
    
    /*
     10. Создайте таймер в апп делегате, который отсчитывает один день за пол секунды.
     11. Когда таймер доходит до дня рождения любого их студентов - поздравлять его с днем рождения.
     */
    
    self.timerDealloc = 0;
    self.arrayOfStudents = arrayForSort;
    self.currentDate = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(printHappyBVariantA:) userInfo:nil repeats:YES];
  
    self.date = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.currentDate];
    NSDate* yesterday = [self.currentDate dateByAddingTimeInterval:-60*60*24];
    
    self.dateForBreakingTimer = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:yesterday];
    self.timerVariant2= [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(printHappyBVariantB:) userInfo:nil repeats:YES];
    
   //SUPER MAN
    
   NSLog(@"Супермен.13. Выведите на экран день недели, для каждого первого дня каждого месяца в текущем году (от начала до конца)");
    
    NSCalendar* calendarForSuperman = [NSCalendar currentCalendar];
    
    NSDateComponents* componentForSuperman = [[NSDateComponents alloc] init];
    
    [componentForSuperman setYear:2015];
    [componentForSuperman setDay:1];
    
    for (int i =1 ; i <13 ; i++) {
        [componentForSuperman setMonth:i];
        NSDate* date = [calendarForSuperman dateFromComponents:componentForSuperman];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSString* weekDay = [dateFormatter stringFromDate:date];
        [dateFormatter setDateFormat:@"MMMM"];
        NSString* month = [dateFormatter stringFromDate:date];
        
        NSLog(@"1st day of month %@ in %ld year was %@", month, componentForSuperman.year, weekDay);
        
    }
    
    
    NSLog(@"супермен14. Выведите дату (число и месяц) для каждого воскресенья в текущем году (от начала до конца)");
    
    NSLog(@"superman15. Выведите количество рабочих дней для каждого месяца в текущем году (от начала до конца)");

    
    NSCalendar* calendarForSuperman2 = [NSCalendar currentCalendar];
    
    NSDateComponents* componentForSuperman2 = [[NSDateComponents alloc] init];
    [componentForSuperman2 setYear:2015];
    [componentForSuperman2 setWeekday:1];
    [componentForSuperman2 setWeekdayOrdinal:1];
    int countOfSunday = 0;
    
    NSDate* dateForTaskFourteen = [calendarForSuperman2 dateFromComponents:componentForSuperman2];
    NSDateFormatter* dateFormatterForTaskFourteen = [[NSDateFormatter alloc] init];
    
    while ([[calendarForSuperman2 components:NSCalendarUnitYear fromDate:dateForTaskFourteen] year] == 2015) {
        [dateFormatterForTaskFourteen setDateFormat:@"dd MMMM"];
        NSString* sundayDate = [dateFormatterForTaskFourteen stringFromDate:dateForTaskFourteen];
        NSLog(@"%ld sunday in %ld year %@", componentForSuperman2.weekdayOrdinal, componentForSuperman2.year, sundayDate);
        componentForSuperman2.weekdayOrdinal++;
        dateForTaskFourteen = [calendarForSuperman2 dateFromComponents:componentForSuperman2];
        countOfSunday++;
    }
      
    NSDateComponents* component1 = [[NSDateComponents alloc] init];
    [component1 setYear:2015];
    [component1 setWeekday:7];
    [component1 setWeekdayOrdinal:1];
    int countOfSuturday = 0;
    
    NSDate* date1 = [calendarForSuperman dateFromComponents:component1];
    
    while ([[calendarForSuperman components:NSCalendarUnitYear fromDate:date1]year] == 2015) {
        [dateFormatterForTaskFourteen setDateFormat:@"dd MMMM"];
        
        //NSString* saturdayDate = [dateFormatterForTaskFourteen stringFromDate:date1];
        component1.weekdayOrdinal++;
        countOfSuturday++;
        date1 = [calendarForSuperman dateFromComponents:component1];
    }
    
    
    int countOfWorkDay = 0;
    countOfWorkDay = 365 - (countOfSunday+countOfSuturday);
    NSLog(@"so amount of work days - %d", countOfWorkDay);
    
    return YES;
}

- (void) printHappyBVariantA:(APStudent*) student {
    
    
    NSDateFormatter* dateStyle = [[NSDateFormatter alloc] init];
    [dateStyle setDateFormat:@"dd.MM.yyyy"];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    self.date = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.currentDate];

    BOOL todayIsBirthday = NO;
    
    for (APStudent* student in self.arrayOfStudents) {
        [dateStyle setDateFormat:@"dd.MM"];
        
        if ([[dateStyle stringFromDate:self.currentDate] isEqualToString:[dateStyle stringFromDate:student.dateOfBirth ]]) {
            [dateStyle setDateFormat:@"dd.MM"];
               todayIsBirthday = YES;
            NSLog(@"today : %@ birthday of %@", [dateStyle stringFromDate:[calendar dateFromComponents:self.date]], student.name);
        }
        [dateStyle setDateFormat:@"dd.MM"];

    }
    
    todayIsBirthday ? todayIsBirthday = NO : NSLog(@"no BD for today - %@", [dateStyle stringFromDate:[calendar dateFromComponents:self.date]]);
    
    self.currentDate = [self.currentDate dateByAddingTimeInterval:24*60*60];
    

    // here we go break timer
    self.timerDealloc = self.timerDealloc+1; // yes, 366days is excluded, but look variant B - its ok
    
    
    if (self.timerDealloc == 365) {
        [self.timer invalidate];
    }
    
    
}

- (void) printHappyBVariantB: (NSTimer*) timer {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateFormatter* dateStyle = [[NSDateFormatter alloc] init];
    
    [dateStyle setDateFormat:@"MMMM,dd:"];
  
    NSDate* todayDate = [calendar dateFromComponents:self.date];
    
    NSLog(@"%@", [dateStyle stringFromDate:todayDate]);
    
    for (APStudent* student in self.arrayOfStudents) {
        
        NSDateComponents* studentDateComponent = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:student.dateOfBirth];
        
        if ([studentDateComponent day]==[self.date day] && [studentDateComponent month] == [self.date month]) {
            NSLog(@"today : %@ birthday of %@", [dateStyle stringFromDate:[calendar dateFromComponents:studentDateComponent]], student.name);
        }
        
    }
    // here we go break timer
    if ([self.dateForBreakingTimer day]==[self.date day] &&
        [self.dateForBreakingTimer month] == [self.date month]) {
        [timer invalidate];
    }
    
    NSDateComponents* dayComponents = [[NSDateComponents alloc] init];
    
    [dayComponents setDay:1];
    
    NSDate* tomorrowDate = [calendar dateByAddingComponents:dayComponents toDate:todayDate options:0];
    
    self.date = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:tomorrowDate];
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
