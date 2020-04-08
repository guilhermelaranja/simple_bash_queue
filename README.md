# simple_bash_queue
A simple "queue" implemented in bash script using the linux filesystem.

# How it works

It creates a directory called "queue_data" in the same directory of the queue.sh file.  
Inside that directory every folder is a separete queue.  
Inside each queue directory, every file is a message where filename is the message itself.  
I intended for the content of each message file to be its retry count, but its not implemented yet.  

# Quickstart

- Setup  
Setup the queue by running the script in your current context.  
This will add the `qadd`, `qlist` and `qremove` commands to your context.  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ . ./queue.sh
```

- Adding a message to a queue  
Here the first param is the name of the queue and second parameter is the message itself.  
So you can already see this queue is not intended to be used for anything too complex, remember the message is a filename.  
The message is also its own id. You can't two of the same message.  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ qadd "my_first_queue" "this is the message"
Added "this is the message" to "my_first_queue"
```

- Listing messages  
Here the first param is the name of the queue.
This is what you will use to get the queue messages. It lists the oldest message first.  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ qlist my_first_queue
'this is the message'
```

Lets add more messages so we can see what it looks like.  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ for i in 1 2 3 4 5; do qadd my_first_queue "task_$i"; done
Added task_1 to my_first_queue
Added task_2 to my_first_queue
Added task_3 to my_first_queue
Added task_4 to my_first_queue
Added task_5 to my_first_queue
```

Now we list the messages.  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ qlist my_first_queue
'this is the message'
task_1
task_2
task_3
task_4
task_5
```

- Removing a message  
Here the first param is the name of the queue and the second is the message to be removed.  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ qremove my_first_queue task_3
Removed "task_3" from "my_first_queue"
```

Listing after removal  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ qlist my_first_queue
'this is the message'
task_1
task_2
task_4
task_5
```

 - Listing Queues  
You can list all the queues by calling qlist without any params.  
The result is sorted by update time, oldest first.  
```
guilherme.laranja@swordfishII:~/simple_bash_queue$ qlist
my_first_queue
```

 - Creating Queues  
`qlist` and `qadd` will create the queue if it doesn't exist.  


## Consuming queue example:

```
guilherme.laranja@swordfishII:~/simple_bash_queue$ while read message; do echo "Hey, I'm consuming $message"; qremove my_first_queue "$message"; done <<< $(qlist my_first_queue)
Hey, I'm consuming this is the message
Removed "this is the message" from "my_first_queue"
Hey, I'm consuming task_1
Removed "task_1" from "my_first_queue"
Hey, I'm consuming task_2
Removed "task_2" from "my_first_queue"
Hey, I'm consuming task_4
Removed "task_4" from "my_first_queue"
Hey, I'm consuming task_5
Removed "task_5" from "my_first_queue"
guilherme.laranja@swordfishII:~/simple_bash_queue$ qlist my_first_queue
```

As you can see, handling whitespaces on the message (which is a filename) is a bit of a pain. It works, but I would avoid it.