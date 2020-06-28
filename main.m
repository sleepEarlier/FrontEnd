//
//  main.m
//  CommandLine
//
//  Created by KimiLin on 2019/2/21.
//  Copyright © 2019年 Algorithm. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#import <string.h>

#define LENGTH(array) ( (sizeof(array)) / (sizeof(array[0])) )

typedef struct ListNode {
    int val;
    struct ListNode *next;
}ListNode;

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
}TreeNode, *TreeNodePtr;

void printListNode(ListNode *head) {
    ListNode *tmp = head;
    while (tmp != NULL) {
        printf("%d ", tmp->val);
        tmp = tmp->next;
    }
    printf("\n");
}

ListNode* deleteDuplicateNode(ListNode *head) {
    // 仅删除重复项 1>1>2 ==> 1>2
    if (head == NULL || head->next == NULL) {
        return head;
    }
    ListNode *resultHead = head;
    ListNode *resultTail = resultHead;
    while ((head = head->next) != NULL) {
        if (resultTail->val != head->val) {
            resultTail->next = head;
            resultTail = resultTail->next;
        }
    }
    resultTail->next = NULL;
    return resultHead;
}

ListNode* deleteDuplicateNode2(ListNode *head) {
    // 同时删除重复和被重复的节点: 1>1>2>3 ==> 2>3
    if (head == NULL || head->next == NULL) {
        return head;
    }
    ListNode *next = head->next;
    if (head->val == next->val) {
        // 相等，找到下一个不等的节点作为头节点
        while (next != NULL && head->val == next->val) {
            next = next->next;
        }
        return deleteDuplicateNode2(next);
    }
    else {
        // 不相等，头节点的next为下一个不相等的节点
        head->next = deleteDuplicateNode2(head->next);
        return head;
    }
    return head;
}

ListNode* deleteNodeFromNode(ListNode *head, ListNode *toDel) {
    if (head == NULL || toDel == NULL) {
        return head;
    }
    // 1. 删除非尾结点
    if (toDel->next != NULL) {
        // 直接将想删除的节点置为下一个节点
        ListNode *next = toDel->next;
        toDel->val = next->val;
        toDel->next = next->next;
    }
    else {
        // 2. 删除尾结点
        // 仅有一个节点
        if (head == toDel) {
            head = NULL;
        }
        else {
            // 找到倒数第二个节点，将next置空
            ListNode *pre = head;
            while (pre->next != toDel) {
                pre = pre->next;
            }
            pre->next = NULL;
        }
    }
    return head;
}

int findRepeat(int arr[], int len) {
    int arrSum = 0;
    int seqSum = 0;
    for (int i = 0; i < len - 1; i++) {
        arrSum += arr[i];
        seqSum += i+1;
    }
    arrSum += arr[len - 1];
    int rst = arrSum - seqSum;
    return rst;
}

void printArr(int a[], int len) {
    for (int i = 0; i < len; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

void bucket_sort(int a[], int n, int max) {
    int i, j;
    int *buckets;
    
    int memLen = max * sizeof(int);
    if ((buckets=(int *)malloc(memLen)) == NULL) {
        return;
    }
    memset(buckets, 0, memLen);
    
    printArr(buckets, max);
    
    // 1. 计数
    for (i = 0; i < n; i++) {
        int tmp = a[i];
        buckets[tmp]++;
        printf("bucket %d = %d\n", tmp , buckets[tmp]);
    }

    printArr(buckets, max);
    
    // 2. 排序
    for (i = 0, j = 0; i < max; i++) {
//        int tmp = buckets[i]--;
        while ( (buckets[i]--) > 0 ) {
            a[j++] = i;
        }
        printArr(a, n);
    }
    free(buckets);
}

void listNodeTest(void) {
    ListNode *first = (ListNode *)malloc(sizeof(ListNode));
    first->val = 1;
    
    ListNode *sec = (ListNode *)malloc(sizeof(ListNode));
    sec->val = 2;
    first->next = sec;
    
    ListNode *third = (ListNode *)malloc(sizeof(ListNode));
    third->val = 2;
    sec->next = third;
    
    ListNode *four = (ListNode *)malloc(sizeof(ListNode));
    four->val = 3;
    third->next = four;
    
    four->next = NULL;
    
    //    first = deleteDuplicateNode(first);
    //    first = deleteNodeFromNode(first, first);
    first = deleteDuplicateNode2(first);
    
    printListNode(first);
}

void preOrderEum(TreeNode *root) {
    if (root != NULL) {
        printf("%d ", root->val);
        preOrderEum(root->left);
        preOrderEum(root->right);
    }
}

void inOrderEum(TreeNode *root) {
    if (root != NULL) {
        inOrderEum(root->left);
        printf("%d ", root->val);
        inOrderEum(root->right);
    }
}

void postOrderEum(TreeNode *root) {
    if (root != NULL) {
        postOrderEum(root->left);
        postOrderEum(root->right);
        printf("%d ", root->val);
    }
}

int enqIdx = 0, deqIdx = 0;

void enqueue(TreeNodePtr *arr, TreeNodePtr node) {
    arr[enqIdx++] = node;
}

TreeNodePtr dequeue(TreeNodePtr *arr) {
    return arr[deqIdx++];
}

void layerOrderEum(TreeNodePtr root, int layerCount) {
    int leafs = pow(2, layerCount - 1);
    TreeNodePtr *arr;
    int size = leafs * sizeof(TreeNode);
    arr = (TreeNodePtr *)malloc(size);
    enqueue(arr, root);
    while (deqIdx < enqIdx) {
        TreeNodePtr node = dequeue(arr);
        printf("%d ", node->val);
        
        if (node->left != NULL) {
            enqueue(arr, node->left);
        }
        
        if (node->right != NULL) {
            enqueue(arr, node->right);
        }
    }
}

TreeNode* createTree() {
    TreeNodePtr a = (TreeNode *)malloc(sizeof(TreeNode));
    a->val = 1;
    a->left = NULL;
    a->right = NULL;
    TreeNodePtr b = (TreeNode *)malloc(sizeof(TreeNode));
    b->val = 2;
    b->left = NULL;
    b->right = NULL;
    TreeNodePtr c = (TreeNode *)malloc(sizeof(TreeNode));
    c->val = 3;
    c->left = NULL;
    c->right = NULL;
    TreeNodePtr d = (TreeNode *)malloc(sizeof(TreeNode));
    d->val = 4;
    d->left = NULL;
    d->right = NULL;
    TreeNodePtr e = (TreeNode *)malloc(sizeof(TreeNode));
    e->val = 5;
    e->left = NULL;
    e->right = NULL;
    TreeNodePtr f = (TreeNode *)malloc(sizeof(TreeNode));
    f->val = 6;
    f->left = NULL;
    f->right = NULL;
    TreeNodePtr g = (TreeNode *)malloc(sizeof(TreeNode));
    g->val = 7;
    g->left = NULL;
    g->right = NULL;
    TreeNodePtr h = (TreeNode *)malloc(sizeof(TreeNode));
    h->val = 8;
    h->left = NULL;
    h->right = NULL;
    
    a->left = b;
    a->right = c;
    b->left = d;
    b->right = e;
    c->left = NULL;
    c->right = f;
    d->left = NULL;
    d->right = NULL;
    e->left = g;
    e->right = h;
    return  a;
}

int coinChange(int coins[], int count, int amount) {
    
    int *dp;
    int len = amount + 1;
    dp = (int *)malloc(sizeof(int) * len);
    dp[0] = 0;
    for (int i = 1; i < len; i++) {
        dp[i] = len;
    }
    printArr(dp, len);
    
    for (int i = 0; i < len; i++) {
        for (int j = 0; j < count; j++) {
            int coin = coins[j];
            if (i - coin < 0) {
                printf("i=%d coin=%d coninue\n",i, coin);
                continue;
            }
            int res_i = MIN(dp[i], 1+dp[i-coin]);
            dp[i] = res_i;
            printf("dp[%d]=%d coin=%d\n", i, res_i, coin);
        }
    }
    int res = dp[amount];
    res = (res == amount + 1)? -1 :res;
    printf("coins:%d\n", res);
    return res;
}

int maxProfit_k_1(int prices[], int len) {
    // k = 1
    int dp_i_0 = 0, dp_i_1 = INT_MIN;
    for (int i = 0; i < len; i++) {
        dp_i_0 = MAX(dp_i_0, dp_i_1 + prices[i]);
        dp_i_1 = MAX(dp_i_1, -prices[i]);
        printf("第%d天: dp_i_0:%d, dp_i_1:%d\n", i+1, dp_i_0, dp_i_1);
    }
    printf("profit:%d\n", dp_i_0);
    return dp_i_0;
}

int maxProfile_k_inff(int prices[], int len) {
    int dp_i_0 = 0, dp_i_1 = INT_MIN;
    for (int i = 0; i < len; i++) {
        int temp = dp_i_0;
        dp_i_0 = MAX(dp_i_0, dp_i_1 + prices[i]);
        dp_i_1 = MAX(dp_i_1,temp -prices[i]);
        printf("第%d天: dp_i_0:%d, dp_i_1:%d\n", i+1, dp_i_0, dp_i_1);
    }
    printf("profit:%d\n", dp_i_0);
    return dp_i_0;
}

int main(int argc, const char * argv[]) {
    
//    TreeNodePtr a = createTree();
//
//    preOrderEum(a);
//    printf("\n");
//    inOrderEum(a);
//    printf("\n");
//    postOrderEum(a);
//    printf("\n");
//    layerOrderEum(a, 3);
    
//    int coins[3] = {1,3,5};
//    coinChange(coins, 3, 12);
    
    int prices[5] = {3, 6, 4, 7};
    int len = LENGTH(prices);
    maxProfit_k_1(prices, len);
    return 0;
}
