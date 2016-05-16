//
//  ContactsHook.m
//  EmmLib
//
//  Created by dengxiang on 3/1/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "ContactsHook.h"
#import "fishhook.h"
@import AddressBook;

//void ABAddressBookRequestAccessWithCompletion(ABAddressBookRef addressBook,  ABAddressBookRequestAccessCompletionHandler completion)
static void (*orig_ABAddressBookRequestAccessWithCompletion)(ABAddressBookRef addressBook,  ABAddressBookRequestAccessCompletionHandler completion);
static void my_ABAddressBookRequestAccessWithCompletion(ABAddressBookRef addressBook,  ABAddressBookRequestAccessCompletionHandler completion){
    NSLog(@"####### HOOKED ABAddressBookRequestAccessWithCompletion##########");
    rebind_symbols((struct rebinding[1]){
        {"ABAddressBookRequestAccessWithCompletion", my_ABAddressBookRequestAccessWithCompletion, (void *)&orig_ABAddressBookRequestAccessWithCompletion}
    }, 1);
    orig_ABAddressBookRequestAccessWithCompletion(addressBook, completion);
}

//CFArrayRef ABAddressBookCopyArrayOfAllPeople(ABAddressBookRef addressBook)
static CFArrayRef (*orig_ABAddressBookCopyArrayOfAllPeople)(ABAddressBookRef addressBook);
static CFArrayRef my_ABAddressBookCopyArrayOfAllPeople(ABAddressBookRef addressBook){
    NSLog(@"####### HOOKED ABAddressBookCopyArrayOfAllPeople##########");
    rebind_symbols((struct rebinding[1]){
        {"ABAddressBookCopyArrayOfAllPeople", my_ABAddressBookCopyArrayOfAllPeople, (void *)&orig_ABAddressBookCopyArrayOfAllPeople}
    }, 1);
    return orig_ABAddressBookCopyArrayOfAllPeople(addressBook);
}

//static int (*orig_open)(const char *, int, ...);

@implementation ContactsHook

+ (void) hook{
    rebind_symbols((struct rebinding[2]){
        {"ABAddressBookRequestAccessWithCompletion", my_ABAddressBookRequestAccessWithCompletion, (void *)&orig_ABAddressBookRequestAccessWithCompletion},
        {"ABAddressBookCopyArrayOfAllPeople", my_ABAddressBookCopyArrayOfAllPeople, (void *)&orig_ABAddressBookCopyArrayOfAllPeople}
    }, 2);
    
}

@end
