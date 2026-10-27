.section .rodata
    msg_main_menu:
    .string "\n1.Insert\n2.Delete\n3.Search\n4.Count\n5.Reverse Display\n6.Exit\n"

    msg_main_choice_req:
    .string "Enter your choice:\t"

    msg_main_scan_int:
    .string "%d"

    msg_main_insert_menu:
    .string "\n1.InsertFirst\n2.InsertLast\n3.InsertAt Position\n4.Back\n"

    msg_main_delete_menu:
    .string "\n1.DeleteFirst\n2.DeleteLast\n3.DeleteAt Position\n4.Back\n"

    msg_search_menu:
    .string "\n1.SearchFirstOccurance\n2.SearchLastOccurance\n3.SearchAllOccurances\n4.Back\n"

    msg_main_choice_req_again:
    .string "Enter your choice again:\t"

    msg_main_data_req:
    .string "Enter data to be insert:\t"
    
    msg_search_data_req:
    .string "Enter data to be search:\t"

    msg_main_pos_req:
    .string "Enter position:\t"

    msg_main_invalid_choice:
    .string "Enter valid choice\n"
    
    msg_main_bye:
    .string "Bye...\n"

    msg_mem_failed:
    .string "memory allocation FAILED\n"

    msg_err_del_empty:
    .string "Linked List Empty, Deletion impossible.\n"

    msg_err_search_empty:
    .string "Linked List Empty, Searching impossible.\n"

    msg_pos_invalid:
    .string "Position is invalid\n"
    
    msg_list_empty_gen:
    .string "Linked List Empty\n"

    msg_deleted_data:
    .string "Deleted data is %d\n"

    msg_data_not_found:
    .string "Data not found\n"

    msg_data_found_pos:
    .string "Data found at %d position\n"
    
    msg_data_found_times:
    .string "Data found %d times\n"

    msg_total_nodes:
    .string "Total node present: %d\n"

    msg_disp_list:
    .string "\nLinked list is:\n"

    msg_rev_disp_list:
    .string "\nReverse Linked list is:\n"

    msg_disp_empty:
    .string "EMPTY\n"

    msg_disp_node:
    .string "<- %d ->"

    msg_newline:
    .string "\n"

    msg_del_all_success:
    .string "\nDeleted All Nodes Successfully\n"

.section .text

# ---------------------------------------------------------
# Phase 1: main function 
# ---------------------------------------------------------
.globl  main
.type   main, @function
main:
    pushl   %ebp
    movl    %esp, %ebp          

    subl    $20, %esp           # Allocate stack for locals
    movl    $0, -16(%ebp)       # -16(%ebp) = NULL (pFirst = NULL)
    movl    $0, -20(%ebp)       # -20(%ebp) = NULL (pLast = NULL)

LABEL_MAIN_WHILE_LOOP:
    pushl   $msg_main_menu
    call    printf
    addl    $4, %esp

    pushl   $msg_main_choice_req
    call    printf
    addl    $4, %esp

    leal    -12(%ebp), %ebx     # ebx = address of iChoice
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -12(%ebp), %eax     # eax = iChoice (value)
    cmpl    $1, %eax
    je      LABEL_CASE_1_INSERT
    cmpl    $2, %eax
    je      LABEL_CASE_2_DELETE
    cmpl    $3, %eax
    je      LABEL_CASE_3_SEARCH
    cmpl    $4, %eax
    je      LABEL_CASE_4_COUNT
    cmpl    $5, %eax
    je      LABEL_CASE_5_REVERSE
    cmpl    $6, %eax
    je      LABEL_CASE_6_EXIT
    jmp     LABEL_CASE_DEFAULT

LABEL_CASE_1_INSERT:
LABEL_INSERT_WHILE_LOOP:
    pushl   $msg_main_insert_menu
    call    printf
    addl    $4, %esp

    pushl   $msg_main_choice_req_again
    call    printf
    addl    $4, %esp

    leal    -12(%ebp), %ebx     # ebx = address of iChoice
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -12(%ebp), %eax     # eax = iChoice (value)
    cmpl    $4, %eax
    je      LABEL_MAIN_WHILE_LOOP

    cmpl    $0, %eax
    jle     LABEL_INSERT_INVALID
    cmpl    $3, %eax
    jg      LABEL_INSERT_INVALID

    pushl   $msg_main_data_req
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %ebx      # ebx = address of iNo
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -12(%ebp), %eax     # eax = iChoice (value)
    cmpl    $1, %eax
    je      LABEL_CALL_INSERT_FIRST
    cmpl    $2, %eax
    je      LABEL_CALL_INSERT_LAST
    cmpl    $3, %eax
    je      LABEL_CALL_INSERT_POS
    jmp     LABEL_INSERT_DISPLAY

LABEL_CALL_INSERT_FIRST:
    movl    -4(%ebp), %eax      # eax = iNo (value)
    leal    -20(%ebp), %edx     # edx = address of pLast
    leal    -16(%ebp), %ebx     # ebx = address of pFirst
    pushl   %eax
    pushl   %edx
    pushl   %ebx
    call    InsertFirst
    addl    $12, %esp
    jmp     LABEL_INSERT_DISPLAY

LABEL_CALL_INSERT_LAST:
    movl    -4(%ebp), %eax      # eax = iNo (value)
    leal    -20(%ebp), %edx     # edx = address of pLast
    leal    -16(%ebp), %ebx     # ebx = address of pFirst
    pushl   %eax
    pushl   %edx
    pushl   %ebx
    call    InsertLast
    addl    $12, %esp
    jmp     LABEL_INSERT_DISPLAY

LABEL_CALL_INSERT_POS:
    pushl   $msg_main_pos_req
    call    printf
    addl    $4, %esp

    leal    -8(%ebp), %ebx      # ebx = address of iPos
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -8(%ebp), %eax      # eax = iPos (value)
    movl    -4(%ebp), %edx      # edx = iNo (value)
    leal    -20(%ebp), %ecx     # ecx = address of pLast
    leal    -16(%ebp), %ebx     # ebx = address of pFirst
    pushl   %eax
    pushl   %edx
    pushl   %ecx
    pushl   %ebx
    call    InsertAtPosition
    addl    $16, %esp

LABEL_INSERT_DISPLAY:
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    Display
    addl    $8, %esp
    jmp     LABEL_INSERT_WHILE_LOOP

LABEL_INSERT_INVALID:
    pushl   $msg_main_invalid_choice
    call    printf
    addl    $4, %esp
    jmp     LABEL_INSERT_WHILE_LOOP

LABEL_CASE_2_DELETE:
    cmpl    $0, -16(%ebp)
    jne     LABEL_DELETE_WHILE_LOOP
    pushl   $msg_err_del_empty
    call    printf
    addl    $4, %esp
    jmp     LABEL_MAIN_WHILE_LOOP

LABEL_DELETE_WHILE_LOOP:
    pushl   $msg_main_delete_menu
    call    printf
    addl    $4, %esp

    pushl   $msg_main_choice_req_again
    call    printf
    addl    $4, %esp

    leal    -12(%ebp), %ebx     # ebx = address of iChoice
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -12(%ebp), %eax     # eax = iChoice (value)
    cmpl    $4, %eax
    je      LABEL_MAIN_WHILE_LOOP

    cmpl    $1, %eax
    je      LABEL_CALL_DEL_FIRST
    cmpl    $2, %eax
    je      LABEL_CALL_DEL_LAST
    cmpl    $3, %eax
    je      LABEL_CALL_DEL_POS
    
    pushl   $msg_main_invalid_choice
    call    printf
    addl    $4, %esp
    movl    $4, -12(%ebp)       # -12(%ebp) = 4 (iChoice)
    jmp     LABEL_DELETE_CHECK_END

LABEL_CALL_DEL_FIRST:
    leal    -20(%ebp), %edx     # edx = address of pLast
    leal    -16(%ebp), %ebx     # ebx = address of pFirst
    pushl   %edx
    pushl   %ebx
    call    DeleteFirst
    addl    $8, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iNo)
    jmp     LABEL_DELETE_CHECK_END

LABEL_CALL_DEL_LAST:
    leal    -20(%ebp), %edx     # edx = address of pLast
    leal    -16(%ebp), %ebx     # ebx = address of pFirst
    pushl   %edx
    pushl   %ebx
    call    DeleteLast
    addl    $8, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iNo)
    jmp     LABEL_DELETE_CHECK_END

LABEL_CALL_DEL_POS:
    pushl   $msg_main_pos_req
    call    printf
    addl    $4, %esp
    
    leal    -8(%ebp), %ebx      # ebx = address of iPos
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -8(%ebp), %eax      # eax = iPos (value)
    leal    -20(%ebp), %edx     # edx = address of pLast
    leal    -16(%ebp), %ebx     # ebx = address of pFirst
    pushl   %eax
    pushl   %edx
    pushl   %ebx
    call    DeleteAtPosition
    addl    $12, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iNo)

LABEL_DELETE_CHECK_END:
    cmpl    $-1, -4(%ebp)
    jne     LABEL_DELETE_PRINT_DATA
    pushl   $msg_list_empty_gen
    call    printf
    addl    $4, %esp
    jmp     LABEL_DELETE_WHILE_LOOP

LABEL_DELETE_PRINT_DATA:
    cmpl    $4, -12(%ebp)
    je      LABEL_DELETE_WHILE_LOOP
    cmpl    $-2, -4(%ebp)
    je      LABEL_DELETE_WHILE_LOOP
    
    movl    -4(%ebp), %eax      # eax = iNo (value)
    pushl   %eax
    pushl   $msg_deleted_data
    call    printf
    addl    $8, %esp

    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    Display
    addl    $8, %esp
    jmp     LABEL_DELETE_WHILE_LOOP

LABEL_CASE_3_SEARCH:
    cmpl    $0, -16(%ebp)
    jne     LABEL_SEARCH_WHILE_LOOP
    pushl   $msg_err_search_empty
    call    printf
    addl    $4, %esp
    jmp     LABEL_MAIN_WHILE_LOOP

LABEL_SEARCH_WHILE_LOOP:
    pushl   $msg_search_menu
    call    printf
    addl    $4, %esp

    pushl   $msg_main_choice_req_again
    call    printf
    addl    $4, %esp

    leal    -12(%ebp), %ebx     # ebx = address of iChoice
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -12(%ebp), %eax     # eax = iChoice (value)
    cmpl    $4, %eax
    je      LABEL_MAIN_WHILE_LOOP

    cmpl    $0, %eax
    jle     LABEL_SEARCH_INVALID
    cmpl    $3, %eax
    jg      LABEL_SEARCH_INVALID
    
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    Display
    addl    $8, %esp

    pushl   $msg_search_data_req
    call    printf
    addl    $4, %esp

    leal    -4(%ebp), %ebx      # ebx = address of iNo
    pushl   %ebx
    pushl   $msg_main_scan_int
    call    scanf
    addl    $8, %esp

    movl    -12(%ebp), %eax     # eax = iChoice (value)
    cmpl    $1, %eax
    je      LABEL_CALL_SEARCH_FIRST
    cmpl    $2, %eax
    je      LABEL_CALL_SEARCH_LAST
    cmpl    $3, %eax
    je      LABEL_CALL_SEARCH_ALL
    jmp     LABEL_SEARCH_WHILE_LOOP

LABEL_SEARCH_INVALID:
    pushl   $msg_main_invalid_choice
    call    printf
    addl    $4, %esp
    jmp     LABEL_SEARCH_WHILE_LOOP

LABEL_CALL_SEARCH_FIRST:
    movl    -4(%ebp), %eax      # eax = iNo (value)
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %eax
    pushl   %edx
    pushl   %ebx
    call    SearchFirstOccurance
    addl    $12, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iNo, storing returned iPos)
    jmp     LABEL_SEARCH_PRINT

LABEL_CALL_SEARCH_LAST:
    movl    -4(%ebp), %eax      # eax = iNo (value)
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %eax
    pushl   %edx
    pushl   %ebx
    call    SearchLastOccurance
    addl    $12, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iNo, storing returned iLast)
    jmp     LABEL_SEARCH_PRINT

LABEL_SEARCH_PRINT:
    cmpl    $-1, -4(%ebp)
    jne     LABEL_SEARCH_PRINT_CHECK_NF
    pushl   $msg_list_empty_gen
    call    printf
    addl    $4, %esp
    jmp     LABEL_SEARCH_WHILE_LOOP
LABEL_SEARCH_PRINT_CHECK_NF:
    cmpl    $-2, -4(%ebp)
    jne     LABEL_SEARCH_PRINT_FOUND
    pushl   $msg_data_not_found
    call    printf
    addl    $4, %esp
    jmp     LABEL_SEARCH_WHILE_LOOP
LABEL_SEARCH_PRINT_FOUND:
    movl    -4(%ebp), %eax      # eax = iNo (value)
    pushl   %eax
    pushl   $msg_data_found_pos
    call    printf
    addl    $8, %esp
    jmp     LABEL_SEARCH_WHILE_LOOP

LABEL_CALL_SEARCH_ALL:
    movl    -4(%ebp), %eax      # eax = iNo (value)
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %eax
    pushl   %edx
    pushl   %ebx
    call    SearchAllOccurances
    addl    $12, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iNo, storing returned iCount)
    pushl   %eax
    pushl   $msg_data_found_times
    call    printf
    addl    $8, %esp
    jmp     LABEL_SEARCH_WHILE_LOOP

LABEL_CASE_4_COUNT:
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    Display
    addl    $8, %esp

    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    CountNode
    addl    $8, %esp
    
    pushl   %eax
    pushl   $msg_total_nodes
    call    printf
    addl    $8, %esp
    jmp     LABEL_MAIN_WHILE_LOOP

LABEL_CASE_5_REVERSE:
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    Display
    addl    $8, %esp
    
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    ReverseDisplay
    addl    $8, %esp
    jmp     LABEL_MAIN_WHILE_LOOP

LABEL_CASE_6_EXIT:
    cmpl    $0, -16(%ebp)
    je      LABEL_MAIN_EXIT
    
    movl    -20(%ebp), %edx     # edx = pLast (address)
    movl    -16(%ebp), %ebx     # ebx = pFirst (address)
    pushl   %edx
    pushl   %ebx
    call    Display
    addl    $8, %esp

    leal    -20(%ebp), %edx     # edx = address of pLast
    leal    -16(%ebp), %ebx     # ebx = address of pFirst
    pushl   %edx
    pushl   %ebx
    call    DeleteAllNodes
    addl    $8, %esp

LABEL_MAIN_EXIT:
    pushl   $msg_main_bye
    call    printf
    addl    $4, %esp

    movl    $0, %eax            # eax = 0 (return 0)
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

LABEL_CASE_DEFAULT:
    pushl   $msg_main_invalid_choice
    call    printf
    addl    $4, %esp
    jmp     LABEL_MAIN_WHILE_LOOP

# ---------------------------------------------------------
# Phase 2: Function Definitions
# ---------------------------------------------------------

.globl  InsertFirst
.type   InsertFirst, @function
InsertFirst:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $4, %esp
    movl    $0, -4(%ebp)        # -4(%ebp) = NULL (pNewNode = NULL)

    pushl   $12
    call    malloc
    addl    $4, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (pNewNode = malloc return address)
    cmpl    $0, %eax
    je      LABEL_MALLOC_FAILED

    movl    -4(%ebp), %ebx      # ebx = pNewNode (address)
    movl    16(%ebp), %eax      # eax = iNo (value)
    movl    %eax, 4(%ebx)       # 4(%ebx) = eax (pNewNode->iData = iNo)

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    cmpl    $0, %eax
    jne     LABEL_N_HEAD_INSERT_FIRST       

    # if (NULL == *ppHead)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppHead = pNewNode)
    
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppTail = pNewNode)

    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext = *ppHead)

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %eax        # eax = *ppTail (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax ((*ppHead)->pPrev = *ppTail)
    jmp     LABEL_RET_INSERT_FIRST

LABEL_N_HEAD_INSERT_FIRST:
    # pNewNode->pNext = *ppHead;
    movl    -4(%ebp), %ebx      # ebx = pNewNode (address)
    movl    8(%ebp), %edx       # edx = ppHead (address)
    movl    (%edx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%ebx)       # 8(%ebx) = eax (pNewNode->pNext = *ppHead)

    # (*ppHead)->pPrev = pNewNode;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax ((*ppHead)->pPrev = pNewNode)

    # *ppHead = pNewNode;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppHead = pNewNode)

    # (*ppTail)->pNext = *ppHead;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext = *ppHead)

    # (*ppHead)->pPrev = *ppTail;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %eax        # eax = *ppTail (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax ((*ppHead)->pPrev = *ppTail)

LABEL_RET_INSERT_FIRST:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  InsertLast
.type   InsertLast, @function
InsertLast:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $4, %esp
    movl    $0, -4(%ebp)        # -4(%ebp) = NULL (pNewNode = NULL)

    pushl   $12
    call    malloc
    addl    $4, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (pNewNode = malloc return address)
    cmpl    $0, %eax
    je      LABEL_MALLOC_FAILED

    movl    -4(%ebp), %ebx      # ebx = pNewNode (address)
    movl    16(%ebp), %eax      # eax = iNo (value)
    movl    %eax, 4(%ebx)       # 4(%ebx) = eax (pNewNode->iData = iNo)

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    cmpl    $0, %eax
    jne     LABEL_N_HEAD_INSERT_LAST       

    # if (NULL == *ppHead)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppHead = pNewNode)
    
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppTail = pNewNode)

    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext = *ppHead)

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %eax        # eax = *ppTail (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax ((*ppHead)->pPrev = *ppTail)
    jmp     LABEL_RET_INSERT_LAST

LABEL_N_HEAD_INSERT_LAST:
    # (*ppTail)->pNext = pNewNode;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext = pNewNode)

    # pNewNode->pPrev = *ppTail;
    movl    -4(%ebp), %ebx      # ebx = pNewNode (address)
    movl    12(%ebp), %edx      # edx = ppTail (address)
    movl    (%edx), %eax        # eax = *ppTail (address)
    movl    %eax, 0(%ebx)       # 0(%ebx) = eax (pNewNode->pPrev = *ppTail)

    # *ppTail = pNewNode;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppTail = pNewNode)

    # (*ppTail)->pNext = *ppHead;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext = *ppHead)

    # (*ppHead)->pPrev = *ppTail;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %eax        # eax = *ppTail (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax ((*ppHead)->pPrev = *ppTail)

LABEL_RET_INSERT_LAST:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  InsertAtPosition
.type   InsertAtPosition, @function
InsertAtPosition:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $12, %esp           # -4: pNewNode, -8: pTemp, -12: iCount
    
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    pushl   %edx
    pushl   %eax
    call    CountNode
    addl    $8, %esp
    movl    %eax, -12(%ebp)     # -12(%ebp) = eax (CountNode result iCount)

    movl    20(%ebp), %eax      # eax = iPos (value)
    cmpl    $0, %eax
    jle     LABEL_IAP_INVALID
    movl    -12(%ebp), %edx     # edx = iCount (value)
    addl    $1, %edx            # edx = iCount + 1
    cmpl    %edx, %eax
    jg      LABEL_IAP_INVALID
    jmp     LABEL_IAP_VALID1

LABEL_IAP_INVALID:
    pushl   $msg_pos_invalid
    call    printf
    addl    $4, %esp
    jmp     LABEL_RET_IAP

LABEL_IAP_VALID1:
    movl    20(%ebp), %eax      # eax = iPos (value)
    cmpl    $1, %eax
    jne     LABEL_IAP_VALID2
    movl    16(%ebp), %eax      # eax = iNo (value)
    movl    12(%ebp), %edx      # edx = ppTail (address)
    movl    8(%ebp), %ecx       # ecx = ppHead (address)
    pushl   %eax
    pushl   %edx
    pushl   %ecx
    call    InsertFirst
    addl    $12, %esp
    jmp     LABEL_RET_IAP

LABEL_IAP_VALID2:
    movl    20(%ebp), %eax      # eax = iPos (value)
    movl    -12(%ebp), %edx     # edx = iCount (value)
    addl    $1, %edx            # edx = iCount + 1
    cmpl    %edx, %eax
    jne     LABEL_IAP_TRAVERSE
    movl    16(%ebp), %eax      # eax = iNo (value)
    movl    12(%ebp), %edx      # edx = ppTail (address)
    movl    8(%ebp), %ecx       # ecx = ppHead (address)
    pushl   %eax
    pushl   %edx
    pushl   %ecx
    call    InsertLast
    addl    $12, %esp
    jmp     LABEL_RET_IAP

LABEL_IAP_TRAVERSE:
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, -8(%ebp)      # -8(%ebp) = eax (*ppHead for pTemp)
    movl    $1, -12(%ebp)       # -12(%ebp) = 1 (iCount)

LABEL_IAP_WHILE:
    movl    20(%ebp), %eax      # eax = iPos (value)
    subl    $1, %eax            # eax = iPos - 1
    movl    -12(%ebp), %edx     # edx = iCount (value)
    cmpl    %eax, %edx
    jge     LABEL_IAP_INSERT
    
    movl    -12(%ebp), %eax     # eax = iCount (value)
    addl    $1, %eax            # eax = iCount + 1
    movl    %eax, -12(%ebp)     # -12(%ebp) = eax (updated iCount)
    
    movl    -8(%ebp), %ebx      # ebx = pTemp (address)
    movl    8(%ebx), %eax       # eax = pTemp->pNext (address)
    movl    %eax, -8(%ebp)      # -8(%ebp) = eax (updated pTemp)
    jmp     LABEL_IAP_WHILE

LABEL_IAP_INSERT:
    pushl   $12
    call    malloc
    addl    $4, %esp
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (newly allocated memory for pNewNode)
    
    cmpl    $0, %eax
    je      LABEL_MALLOC_FAILED

    movl    -4(%ebp), %ebx      # ebx = pNewNode (address)
    movl    16(%ebp), %eax      # eax = iNo (value)
    movl    %eax, 4(%ebx)       # 4(%ebx) = eax (pNewNode->iData = iNo)

    # pNewNode->pNext = pTemp->pNext;
    movl    -4(%ebp), %ebx      # ebx = pNewNode (address)
    movl    -8(%ebp), %edx      # edx = pTemp (address)
    movl    8(%edx), %eax       # eax = pTemp->pNext (address)
    movl    %eax, 8(%ebx)       # 8(%ebx) = eax (pNewNode->pNext)

    # pTemp->pNext->pPrev = pNewNode;
    movl    -8(%ebp), %ebx      # ebx = pTemp (address)
    movl    8(%ebx), %edx       # edx = pTemp->pNext (address)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax (pTemp->pNext->pPrev)

    # pTemp->pNext = pNewNode;
    movl    -8(%ebp), %ebx      # ebx = pTemp (address)
    movl    -4(%ebp), %eax      # eax = pNewNode (address)
    movl    %eax, 8(%ebx)       # 8(%ebx) = eax (pTemp->pNext)

    # pNewNode->pPrev = pTemp;
    movl    -4(%ebp), %ebx      # ebx = pNewNode (address)
    movl    -8(%ebp), %eax      # eax = pTemp (address)
    movl    %eax, 0(%ebx)       # 0(%ebx) = eax (pNewNode->pPrev)

LABEL_RET_IAP:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  DeleteFirst
.type   DeleteFirst, @function
DeleteFirst:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $4, %esp            # -4: iDelData
    
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    cmpl    $0, %eax
    jne     LABEL_DF_CONT
    movl    $-1, %eax           # eax = -1 (return value)
    jmp     LABEL_RET_DF

LABEL_DF_CONT:
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    4(%edx), %eax       # eax = (*ppHead)->iData (value)
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iDelData)

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    cmpl    %edx, %eax
    jne     LABEL_DF_MULTI
    
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    $0, 8(%eax)         # 8(%eax) = NULL ((*ppHead)->pNext)
    movl    $0, 0(%eax)         # 0(%eax) = NULL ((*ppHead)->pPrev)
    
    pushl   %eax
    call    free
    addl    $4, %esp

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    $0, (%ebx)          # (%ebx) = NULL (*ppHead)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    $0, (%ebx)          # (%ebx) = NULL (*ppTail)
    
    movl    -4(%ebp), %eax      # eax = iDelData (return value)
    jmp     LABEL_RET_DF

LABEL_DF_MULTI:
    # *ppHead = (*ppHead)->pNext;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    8(%edx), %eax       # eax = (*ppHead)->pNext (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppHead = new head)

    # (*ppTail)->pNext->pNext = NULL;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%edx), %eax       # eax = (*ppTail)->pNext (address)
    movl    $0, 8(%eax)         # 8(%eax) = NULL ((*ppTail)->pNext->pNext)

    # (*ppTail)->pNext->pPrev = NULL;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%edx), %eax       # eax = (*ppTail)->pNext (address)
    movl    $0, 0(%eax)         # 0(%eax) = NULL ((*ppTail)->pNext->pPrev)

    # free((*ppTail)->pNext);
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%edx), %eax       # eax = (*ppTail)->pNext (address)
    pushl   %eax
    call    free
    addl    $4, %esp

    # (*ppTail)->pNext = *ppHead;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext)

    # (*ppHead)->pPrev = *ppTail;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %eax        # eax = *ppTail (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax ((*ppHead)->pPrev)

    movl    -4(%ebp), %eax      # eax = iDelData (return value)

LABEL_RET_DF:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  DeleteLast
.type   DeleteLast, @function
DeleteLast:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $4, %esp            # -4: iDelData
    
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    cmpl    $0, %eax
    jne     LABEL_DL_CONT
    movl    $-1, %eax           # eax = -1 (return value)
    jmp     LABEL_RET_DL

LABEL_DL_CONT:
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    4(%edx), %eax       # eax = (*ppTail)->iData (value)
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (iDelData)

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    cmpl    %edx, %eax
    jne     LABEL_DL_MULTI
    
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    $0, 8(%eax)         # 8(%eax) = NULL ((*ppHead)->pNext)
    movl    $0, 0(%eax)         # 0(%eax) = NULL ((*ppHead)->pPrev)
    
    pushl   %eax
    call    free
    addl    $4, %esp

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    $0, (%ebx)          # (%ebx) = NULL (*ppHead)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    $0, (%ebx)          # (%ebx) = NULL (*ppTail)
    
    movl    -4(%ebp), %eax      # eax = iDelData (return value)
    jmp     LABEL_RET_DL

LABEL_DL_MULTI:
    # *ppTail = (*ppTail)->pPrev;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    0(%edx), %eax       # eax = (*ppTail)->pPrev (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppTail = new tail)

    # (*ppHead)->pPrev->pNext = NULL;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    0(%edx), %eax       # eax = (*ppHead)->pPrev (address)
    movl    $0, 8(%eax)         # 8(%eax) = NULL ((*ppHead)->pPrev->pNext)

    # (*ppHead)->pPrev->pPrev = NULL;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    0(%edx), %eax       # eax = (*ppHead)->pPrev (address)
    movl    $0, 0(%eax)         # 0(%eax) = NULL ((*ppHead)->pPrev->pPrev)

    # free((*ppHead)->pPrev);
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    0(%edx), %eax       # eax = (*ppHead)->pPrev (address)
    pushl   %eax
    call    free
    addl    $4, %esp

    # (*ppTail)->pNext = *ppHead;
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext)

    # (*ppHead)->pPrev = *ppTail;
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %eax        # eax = *ppTail (address)
    movl    %eax, 0(%edx)       # 0(%edx) = eax ((*ppHead)->pPrev)

    movl    -4(%ebp), %eax      # eax = iDelData (return value)

LABEL_RET_DL:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  DeleteAtPosition
.type   DeleteAtPosition, @function
DeleteAtPosition:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $8, %esp            # -4: pTemp, -8: iCount
    
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    pushl   %edx
    pushl   %eax
    call    CountNode
    addl    $8, %esp
    movl    %eax, -8(%ebp)      # -8(%ebp) = eax (CountNode result iCount)

    movl    16(%ebp), %eax      # eax = iPos (value)
    cmpl    $0, %eax
    jle     LABEL_DAP_INVALID
    movl    -8(%ebp), %edx      # edx = iCount (value)
    cmpl    %edx, %eax
    jg      LABEL_DAP_INVALID
    jmp     LABEL_DAP_VALID1

LABEL_DAP_INVALID:
    pushl   $msg_pos_invalid
    call    printf
    addl    $4, %esp
    movl    $-2, %eax           # eax = -2 (return value)
    jmp     LABEL_RET_DAP

LABEL_DAP_VALID1:
    movl    16(%ebp), %eax      # eax = iPos (value)
    cmpl    $1, %eax
    jne     LABEL_DAP_VALID2
    movl    12(%ebp), %edx      # edx = ppTail (address)
    movl    8(%ebp), %ecx       # ecx = ppHead (address)
    pushl   %edx
    pushl   %ecx
    call    DeleteFirst
    addl    $8, %esp
    jmp     LABEL_RET_DAP

LABEL_DAP_VALID2:
    movl    16(%ebp), %eax      # eax = iPos (value)
    movl    -8(%ebp), %edx      # edx = iCount (value)
    cmpl    %edx, %eax
    jne     LABEL_DAP_TRAVERSE
    movl    12(%ebp), %edx      # edx = ppTail (address)
    movl    8(%ebp), %ecx       # ecx = ppHead (address)
    pushl   %edx
    pushl   %ecx
    call    DeleteLast
    addl    $8, %esp
    jmp     LABEL_RET_DAP

LABEL_DAP_TRAVERSE:
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (*ppHead for pTemp)
    movl    $1, -8(%ebp)        # -8(%ebp) = 1 (iCount)

LABEL_DAP_WHILE:
    movl    16(%ebp), %eax      # eax = iPos (value)
    movl    -8(%ebp), %edx      # edx = iCount (value)
    cmpl    %eax, %edx
    jge     LABEL_DAP_DELETE
    
    movl    -8(%ebp), %eax      # eax = iCount (value)
    addl    $1, %eax            # eax = iCount + 1
    movl    %eax, -8(%ebp)      # -8(%ebp) = eax (updated iCount)
    
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    8(%ebx), %eax       # eax = pTemp->pNext (address)
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (updated pTemp)
    jmp     LABEL_DAP_WHILE

LABEL_DAP_DELETE:
    # pTemp->pPrev->pNext = pTemp->pNext;
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    0(%ebx), %eax       # eax = pTemp->pPrev (address)
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    8(%ebx), %edx       # edx = pTemp->pNext (address)
    movl    %edx, 8(%eax)       # 8(%eax) = edx (pTemp->pPrev->pNext)

    # pTemp->pNext->pPrev = pTemp->pPrev;
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    8(%ebx), %eax       # eax = pTemp->pNext (address)
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    0(%ebx), %edx       # edx = pTemp->pPrev (address)
    movl    %edx, 0(%eax)       # 0(%eax) = edx (pTemp->pNext->pPrev)

    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    $0, 8(%ebx)         # 8(%ebx) = NULL (pTemp->pNext)
    
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    $0, 0(%ebx)         # 0(%ebx) = NULL (pTemp->pPrev)
    
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    movl    4(%ebx), %eax       # eax = pTemp->iData (value)
    movl    %eax, -8(%ebp)      # -8(%ebp) = eax (iCount used to hold deleted data temporarily)
    
    movl    -4(%ebp), %ebx      # ebx = pTemp (address)
    pushl   %ebx
    call    free
    addl    $4, %esp

    movl    -8(%ebp), %eax      # eax = iCount (deleted data return value)

LABEL_RET_DAP:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  SearchFirstOccurance
.type   SearchFirstOccurance, @function
SearchFirstOccurance:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $4, %esp            # -4: iPos
    
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    $0, %eax
    jne     LABEL_SFO_CONT
    movl    $-1, %eax           # eax = -1 (return value)
    jmp     LABEL_RET_SFO

LABEL_SFO_CONT:
    movl    $1, -4(%ebp)        # -4(%ebp) = 1 (iPos)

LABEL_SFO_DO_WHILE:
    movl    16(%ebp), %edx      # edx = iKey (value)
    movl    8(%ebp), %ebx       # ebx = pHead (address)
    cmpl    %edx, 4(%ebx)       # pHead->iData == iKey
    je      LABEL_SFO_END_LOOP

    movl    -4(%ebp), %eax      # eax = iPos (value)
    addl    $1, %eax            # eax = iPos + 1
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (updated iPos)

    movl    8(%ebp), %ebx       # ebx = pHead (address)
    movl    8(%ebx), %eax       # eax = pHead->pNext (address)
    movl    %eax, 8(%ebp)       # 8(%ebp) = eax (pHead = pHead->pNext)
    
    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    8(%ebx), %edx       # edx = pTail->pNext (address)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    %edx, %eax
    jne     LABEL_SFO_DO_WHILE

LABEL_SFO_END_LOOP:
    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    8(%ebx), %edx       # edx = pTail->pNext (address)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    %edx, %eax
    jne     LABEL_SFO_RET_POS
    
    movl    -4(%ebp), %eax      # eax = iPos (value)
    cmpl    $1, %eax
    je      LABEL_SFO_RET_POS
    movl    $-2, %eax           # eax = -2 (return value)
    jmp     LABEL_RET_SFO

LABEL_SFO_RET_POS:
    movl    -4(%ebp), %eax      # eax = iPos (value)

LABEL_RET_SFO:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  SearchLastOccurance
.type   SearchLastOccurance, @function
SearchLastOccurance:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $8, %esp            # -4: iPos, -8: iLast
    
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    $0, %eax
    jne     LABEL_SLO_CONT
    movl    $-1, %eax           # eax = -1 (return value)
    jmp     LABEL_RET_SLO

LABEL_SLO_CONT:
    movl    $1, -4(%ebp)        # -4(%ebp) = 1 (iPos)
    movl    $0, -8(%ebp)        # -8(%ebp) = 0 (iLast)

LABEL_SLO_DO_WHILE:
    movl    16(%ebp), %edx      # edx = iKey (value)
    movl    8(%ebp), %ebx       # ebx = pHead (address)
    cmpl    %edx, 4(%ebx)       # pHead->iData == iKey
    jne     LABEL_SLO_NEXT

    movl    -4(%ebp), %eax      # eax = iPos (value)
    movl    %eax, -8(%ebp)      # -8(%ebp) = eax (iLast = iPos)

LABEL_SLO_NEXT:
    movl    -4(%ebp), %eax      # eax = iPos (value)
    addl    $1, %eax            # eax = iPos + 1
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (updated iPos)
    
    movl    8(%ebp), %ebx       # ebx = pHead (address)
    movl    8(%ebx), %eax       # eax = pHead->pNext (address)
    movl    %eax, 8(%ebp)       # 8(%ebp) = eax (pHead = pHead->pNext)
    
    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    8(%ebx), %edx       # edx = pTail->pNext (address)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    %edx, %eax
    jne     LABEL_SLO_DO_WHILE

    movl    -8(%ebp), %eax      # eax = iLast (value)
    cmpl    $0, %eax
    jne     LABEL_SLO_RET_POS
    movl    $-2, %eax           # eax = -2 (return value)
    jmp     LABEL_RET_SLO

LABEL_SLO_RET_POS:
    movl    -8(%ebp), %eax      # eax = iLast (value)

LABEL_RET_SLO:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  SearchAllOccurances
.type   SearchAllOccurances, @function
SearchAllOccurances:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $4, %esp            # -4: iCount
    
    movl    $0, -4(%ebp)        # -4(%ebp) = 0 (iCount)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    $0, %eax
    je      LABEL_SAO_RET

LABEL_SAO_DO_WHILE:
    movl    16(%ebp), %edx      # edx = iKey (value)
    movl    8(%ebp), %ebx       # ebx = pHead (address)
    cmpl    %edx, 4(%ebx)       # pHead->iData == iKey
    jne     LABEL_SAO_NEXT

    movl    -4(%ebp), %eax      # eax = iCount (value)
    addl    $1, %eax            # eax = iCount + 1
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (updated iCount)

LABEL_SAO_NEXT:
    movl    8(%ebp), %ebx       # ebx = pHead (address)
    movl    8(%ebx), %eax       # eax = pHead->pNext (address)
    movl    %eax, 8(%ebp)       # 8(%ebp) = eax (pHead = pHead->pNext)
    
    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    8(%ebx), %edx       # edx = pTail->pNext (address)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    %edx, %eax
    jne     LABEL_SAO_DO_WHILE

LABEL_SAO_RET:
    movl    -4(%ebp), %eax      # eax = iCount (return value)
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  CountNode
.type   CountNode, @function
CountNode:
    pushl   %ebp
    movl    %esp, %ebp          
    subl    $4, %esp            # -4: iCount
    
    movl    $0, -4(%ebp)        # -4(%ebp) = 0 (iCount)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    $0, %eax
    je      LABEL_CN_RET

LABEL_CN_DO_WHILE:
    movl    -4(%ebp), %eax      # eax = iCount (value)
    addl    $1, %eax            # eax = iCount + 1
    movl    %eax, -4(%ebp)      # -4(%ebp) = eax (updated iCount)
    
    movl    8(%ebp), %ebx       # ebx = pHead (address)
    movl    8(%ebx), %eax       # eax = pHead->pNext (address)
    movl    %eax, 8(%ebp)       # 8(%ebp) = eax (pHead = pHead->pNext)
    
    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    8(%ebx), %edx       # edx = pTail->pNext (address)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    %edx, %eax
    jne     LABEL_CN_DO_WHILE

LABEL_CN_RET:
    movl    -4(%ebp), %eax      # eax = iCount (return value)
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  Display
.type   Display, @function
Display:
    pushl   %ebp
    movl    %esp, %ebp          
    
    pushl   $msg_disp_list
    call    printf
    addl    $4, %esp

    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    $0, %eax
    jne     LABEL_DISP_DO_WHILE
    
    pushl   $msg_disp_empty
    call    printf
    addl    $4, %esp
    jmp     LABEL_RET_DISP

LABEL_DISP_DO_WHILE:
    movl    8(%ebp), %ebx       # ebx = pHead (address)
    movl    4(%ebx), %eax       # eax = pHead->iData (value)
    pushl   %eax
    pushl   $msg_disp_node
    call    printf
    addl    $8, %esp

    movl    8(%ebp), %ebx       # ebx = pHead (address)
    movl    8(%ebx), %eax       # eax = pHead->pNext (address)
    movl    %eax, 8(%ebp)       # 8(%ebp) = eax (pHead = pHead->pNext)

    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    8(%ebx), %edx       # edx = pTail->pNext (address)
    movl    8(%ebp), %eax       # eax = pHead (address)
    cmpl    %edx, %eax
    jne     LABEL_DISP_DO_WHILE

    pushl   $msg_newline
    call    printf
    addl    $4, %esp

LABEL_RET_DISP:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  ReverseDisplay
.type   ReverseDisplay, @function
ReverseDisplay:
    pushl   %ebp
    movl    %esp, %ebp          
    
    pushl   $msg_rev_disp_list
    call    printf
    addl    $4, %esp

    movl    12(%ebp), %eax      # eax = pTail (address)
    cmpl    $0, %eax
    jne     LABEL_RDISP_DO_WHILE
    
    pushl   $msg_disp_empty
    call    printf
    addl    $4, %esp
    jmp     LABEL_RET_RDISP

LABEL_RDISP_DO_WHILE:
    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    4(%ebx), %eax       # eax = pTail->iData (value)
    pushl   %eax
    pushl   $msg_disp_node
    call    printf
    addl    $8, %esp

    movl    12(%ebp), %ebx      # ebx = pTail (address)
    movl    0(%ebx), %eax       # eax = pTail->pPrev (address)
    movl    %eax, 12(%ebp)      # 12(%ebp) = eax (pTail = pTail->pPrev)

    movl    8(%ebp), %ebx       # ebx = pHead (address)
    movl    0(%ebx), %edx       # edx = pHead->pPrev (address)
    movl    12(%ebp), %eax      # eax = pTail (address)
    cmpl    %edx, %eax
    jne     LABEL_RDISP_DO_WHILE

    pushl   $msg_newline
    call    printf
    addl    $4, %esp

LABEL_RET_RDISP:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

.globl  DeleteAllNodes
.type   DeleteAllNodes, @function
DeleteAllNodes:
    pushl   %ebp
    movl    %esp, %ebp          
    
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    cmpl    $0, %eax
    je      LABEL_RET_DAN

LABEL_DAN_WHILE:
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    cmpl    %eax, %edx
    je      LABEL_DAN_END_WHILE

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    $0, 0(%eax)         # 0(%eax) = NULL ((*ppHead)->pPrev = NULL)
    
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %edx        # edx = *ppHead (address)
    movl    8(%edx), %eax       # eax = (*ppHead)->pNext (address)
    movl    %eax, (%ebx)        # (%ebx) = eax (*ppHead = (*ppHead)->pNext)

    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%edx), %eax       # eax = (*ppTail)->pNext (address)
    movl    $0, 8(%eax)         # 8(%eax) = NULL ((*ppTail)->pNext->pNext = NULL)

    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%edx), %eax       # eax = (*ppTail)->pNext (address)
    pushl   %eax
    call    free
    addl    $4, %esp

    # Reload post-free
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    (%ebx), %edx        # edx = *ppTail (address)
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    %eax, 8(%edx)       # 8(%edx) = eax ((*ppTail)->pNext = *ppHead)
    jmp     LABEL_DAN_WHILE

LABEL_DAN_END_WHILE:
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    $0, 8(%eax)         # 8(%eax) = NULL ((*ppHead)->pNext = NULL)
    
    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    movl    $0, 0(%eax)         # 0(%eax) = NULL ((*ppHead)->pPrev = NULL)

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    (%ebx), %eax        # eax = *ppHead (address)
    pushl   %eax
    call    free
    addl    $4, %esp

    movl    8(%ebp), %ebx       # ebx = ppHead (address)
    movl    $0, (%ebx)          # (%ebx) = NULL (*ppHead = NULL)
    
    movl    12(%ebp), %ebx      # ebx = ppTail (address)
    movl    $0, (%ebx)          # (%ebx) = NULL (*ppTail = NULL)

    pushl   $msg_del_all_success
    call    printf
    addl    $4, %esp

LABEL_RET_DAN:
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret

LABEL_MALLOC_FAILED:
    pushl   $msg_mem_failed
    call    printf
    addl    $4, %esp 
    movl    %ebp, %esp          # esp = stack base pointer (restore stack)
    popl    %ebp
    ret


