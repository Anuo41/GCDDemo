//
//  ViewController.m
//  GCDDemo
//
//  Created by DerrickYoung41 on 2020/3/1.
//  Copyright © 2020 DerrickYoung41. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/* 剩余火车票数 */
@property (nonatomic, assign) int ticketSurplusCount;

@end

@implementation ViewController {
    dispatch_semaphore_t semaphoreLock;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    /* 任务+队列 相关方法 */
    //    同步执行 + 并发队列
    //    [self syncConcurrent];
    
    //    异步执行 + 并发队列
    //    [self asyncConcurrent];
    
    //    同步执行 + 串行队列
    //    [self syncSerial];
    
    //    异步执行 + 串行队列
    //    [self asyncSerial];
    
    //    同步执行 + 主队列（主线程调用）
    //    [self syncMain];

    //    同步执行 + 主队列（其他线程调用）
    //[NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    
    //    异步执行 + 主队列
    //    [self asyncMain];
    
        /* GCD 线程间通信 */

        //[self communication];
    
        /* GCD 其他方法 */
        
    //    栅栏方法 dispatch_barrier_async
    //    [self barrier];
    
    //    延时执行方法 dispatch_after
    //    [self after];
        
    //    一次性代码（只执行一次）dispatch_once
    //    [self once];
    
    //    快速迭代方法 dispatch_apply
    //      [self apply];
    
       /* 队列组 gropu */
    //    队列组 dispatch_group_notify
    //    [self groupNotify];
    
    //    队列组 dispatch_group_wait
    //    [self groupWait];
        
    //    队列组 dispatch_group_enter、dispatch_group_leave
    //    [self groupEnterAndLeave];
    
        /* 信号量 dispatch_semaphore */
    //    semaphore 线程同步
    //    [self semaphoreSync];
    
    //    semaphore 线程安全
    //    非线程安全：不使用 semaphore
    //    [self initTicketStatusNotSave];
        
    //    线程安全：使用 semaphore 加锁
        [self initTicketStatusSave];
}

#pragma mark - 任务+队列 相关方法
/**
* 同步执行 + 并发队列
* 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
*/
- (void)syncConcurrent {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"syncConcurrent--begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.yy.test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        //追加任务1
        [NSThread sleepForTimeInterval:1];          //模拟耗时
        NSLog(@"1--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_sync(queue, ^{
        //追加任务2
        [NSThread sleepForTimeInterval:1];          //模拟耗时
        NSLog(@"2--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_sync(queue, ^{
        //追加任务3
        [NSThread sleepForTimeInterval:1];          //模拟耗时
        NSLog(@"3--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    NSLog(@"syncConcurrent---end");
}

/**
* 异步执行 + 并发队列
* 特点：可以开启多个线程，任务交替（同时）执行。
*/
- (void)asyncConcurrent {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"asyncConcurrent--begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.yy.test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        //追加任务1
        [NSThread sleepForTimeInterval:1];          //模拟耗时
        NSLog(@"1--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_async(queue, ^{
        //追加任务2
        [NSThread sleepForTimeInterval:1];          //模拟耗时
        NSLog(@"2--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_async(queue, ^{
        //追加任务3
        [NSThread sleepForTimeInterval:1];          //模拟耗时
        NSLog(@"3--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    NSLog(@"asyncConcurrent---end");
}

/**
* 同步执行 + 串行队列
* 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
*/
- (void)syncSerial {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"syncSerial--begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.yy.test", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        //追加任务1
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"1--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_sync(queue, ^{
        //追加任务2
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"2--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_sync(queue, ^{
        //追加任务3
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"3--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    NSLog(@"syncSerial---end");
}

/**
* 异步执行 + 串行队列
* 特点：会开启一条新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
*/
- (void)asyncSerial {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"asyncSerial--begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.yy.test", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        //追加任务1
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"1--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_async(queue, ^{
        //追加任务2
        [NSThread sleepForTimeInterval:1];          //模拟耗时
        NSLog(@"2--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_async(queue, ^{
        //追加任务3
        [NSThread sleepForTimeInterval:3];          //模拟耗时
        NSLog(@"3--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    NSLog(@"asyncSerial---end");
}

/**
* 同步执行 + 主队列
* 特点(主线程调用)：互等卡主不执行。
* 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
*/
- (void)syncMain {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"syncMain--begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        //追加任务1
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"1--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_sync(queue, ^{
        //追加任务2
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"2--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_sync(queue, ^{
        //追加任务3
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"3--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    NSLog(@"syncMain---end");
}

/**
* 异步执行 + 主队列
* 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
*/
- (void)asyncMain {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"asyncMain--begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        //追加任务1
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"1--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_async(queue, ^{
        //追加任务2
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"2--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    dispatch_async(queue, ^{
        //追加任务3
        [NSThread sleepForTimeInterval:2];          //模拟耗时
        NSLog(@"3--%@",[NSThread currentThread]);   //打印当前线程
    });
    
    NSLog(@"asyncMain---end");
}

#pragma mark - 线程间通信

/**
 * 线程间通信
 */
- (void)communication {
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        //异步追加任务1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1--%@",[NSThread currentThread]);
        
        dispatch_async(mainQueue, ^{
            //追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        });
    });
}

#pragma mark - GCD 其他相关方法
/**
 * 栅栏方法 dispatch_barrier_async
 */
- (void)barrier {
    dispatch_queue_t queue = dispatch_queue_create("com.yy.demo", DISPATCH_QUEUE_CONCURRENT);   //若用全局并发队列，barrier失效
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1--%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2--%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3--%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4--%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"5--%@",[NSThread currentThread]);
    });
}

/**
* 延时执行方法 dispatch_after
*/
- (void)after {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"afterEnd");
    });
}

/**
* 一次性代码（只执行一次）dispatch_once
*/
- (void)once {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         // 只执行 1 次的代码（这里面默认是线程安全的）
    });
}

/**
 * 快速迭代方法 dispatch_apply
 */
- (void)apply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"apply--begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
}

#pragma mark - dispatch_group 队列组

/**
 * 队列组 dispatch_group_notify
 */
- (void)groupNotify {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"groupNotify--begin");
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.yy1.demo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("com.yy2.demo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue3 = dispatch_queue_create("com.yy3.demo", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue1, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1--%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue2, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2--%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue3, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3--%@",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"currentThred--%@",[NSThread currentThread]);
        NSLog(@"groupNotifyend");
    });
}

/**
* 队列组 dispatch_group_wait
*/
- (void)groupWait {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"groupWait--begin");
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1--%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2--%@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3--%@",[NSThread currentThread]);
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);  // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"groupNotify--end");
}

/**
* 队列组 dispatch_group_enter、dispatch_group_leave
*/
- (void)groupEnterAndLeave {
    NSLog(@"currentThred--%@",[NSThread currentThread]);
    NSLog(@"groupEnterAndLeave--begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1--%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2--%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3--%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"currentThred--%@",[NSThread currentThread]);
        NSLog(@"groupEnterAndLeave--end");
    });
}

#pragma mark - semaphore 线程同步
/**
 * semaphore 线程同步
 */
- (void)semaphoreSync {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int testNum = 10;
    
    dispatch_async(queue, ^{
        testNum = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"testNum:%d",testNum);
    NSLog(@"semaphore---end");
}

#pragma mark - semaphore 线程安全
/**
* 非线程安全：不使用 semaphore
* 初始化火车票数量、卖票窗口（非线程安全）、并开始卖票
*/
- (void)initTicketStatusNotSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    self.ticketSurplusCount = 50;
    
    dispatch_queue_t queueGuangZhou = dispatch_queue_create("com.yy.gz", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queueShenZhen = dispatch_queue_create("com.yy.sz", DISPATCH_QUEUE_CONCURRENT);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queueGuangZhou, ^{
        [weakSelf saleTicketsNotSave];
    });
    
    dispatch_async(queueShenZhen, ^{
        [weakSelf saleTicketsNotSave];
    });
}

- (void)saleTicketsNotSave {
    while (1) {
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.3];
        } else {
            NSLog(@"票卖完了");
            break;
        }
    }
}

/**
* 线程安全：使用 semaphore 加锁
* 初始化火车票数量、卖票窗口（线程安全）、并开始卖票
*/
- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    self.ticketSurplusCount = 50;
    
    dispatch_queue_t queueGuangZhou = dispatch_queue_create("com.yy.gz", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queueShenZhen = dispatch_queue_create("com.yy.sz", DISPATCH_QUEUE_CONCURRENT);
    
    semaphoreLock = dispatch_semaphore_create(1);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queueGuangZhou, ^{
        [weakSelf saleTicketsSave];
    });
    
    dispatch_async(queueShenZhen, ^{
        [weakSelf saleTicketsSave];
    });
}

/**
* 售卖火车票（线程安全）
*/
- (void)saleTicketsSave {
    while (1) {
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.3];
            dispatch_semaphore_signal(semaphoreLock);
        } else {
            NSLog(@"票卖完了");
            break;
        }
    }
}


@end
