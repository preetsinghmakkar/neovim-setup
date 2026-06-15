# LeetCode in Neovim — Complete Guide

> Plugin: kawre/leetcode.nvim | Language: **Rust**

---

## IMPORTANT: How This Plugin Works

The plugin has **two modes**:

| How you launch | What happens |
|---------------|-------------|
| `nvim leetcode.nvim` | Full LeetCode session — all commands available |
| Regular `nvim` | Only `:Leet` (go to menu) is available |

**Always use `nvim leetcode.nvim`** when you want to practice. Once inside, all subcommands (`:Leet run`, `:Leet submit`, `:Leet cookie update`, etc.) work.

---

## Table of Contents

1. [First-Time Auth Setup](#first-time-auth-setup)
2. [Daily Workflow](#daily-workflow)
3. [Keymaps Reference](#keymaps-reference)
4. [Solving a Problem](#solving-a-problem)
5. [Test Cases and Console](#test-cases-and-console)
6. [Rust Patterns for LeetCode](#rust-patterns-for-leetcode)
7. [Snippets Quick Reference](#snippets-quick-reference)
8. [Recommended Problem Order](#recommended-problem-order)
9. [Troubleshooting](#troubleshooting)

---

## First-Time Auth Setup

Auth is **UI-driven** — no commands needed. Here is the exact process.

### Step 1: Get your cookie string from the browser

1. Log in to [leetcode.com](https://leetcode.com) in your browser
2. Press `F12` → go to the **Network** tab
3. Refresh the page (`F5`)
4. Click any request to `leetcode.com` in the request list
5. In **Request Headers**, find the `Cookie:` line
6. **Copy the entire value** of that header

It looks like this (very long string):
```
csrftoken=abc123xyz; LEETCODE_SESSION=eyJ0eXAiOiJKV1Q...; _ga=GA1.2.xxx; ...
```

> The string must contain BOTH `csrftoken=...` AND `LEETCODE_SESSION=...` — don't extract individual values, copy the whole thing.

### Step 2: Launch the LeetCode session

```bash
nvim leetcode.nvim
```

The plugin opens. Since there's no cookie yet, it shows the **sign-in page** (not an error).

### Step 3: Press `s` on the sign-in page

The sign-in page has one button: **"Sign in (By Cookie)"**

Press **`s`** (the shortcut key shown next to the button).

A small popup input box appears in the center of the screen.

### Step 4: Paste your cookie and press Enter

Paste the full cookie string you copied in Step 1, then press `Enter`.

- ✅ Success: "Sign-in successful" notification, dashboard loads with your stats
- ❌ Failure: see [Troubleshooting](#troubleshooting)

### Done

Cookie is saved permanently. You won't need to do this again until the session expires (usually weeks–months).

---

> ⚠️ **Why `:Leet auth` and `:Leet cookie update` don't work from regular nvim:**
>
> The `:Leet` subcommand API (run, submit, cookie, list, etc.) only exists **after** `nvim leetcode.nvim` initializes the full session. In a regular `nvim` session, `:Leet` is a zero-argument command — typing `:Leet auth` gives `E488: Trailing characters`. Auth must be done through the UI described above.

---

## Daily Workflow

```bash
# Launch LeetCode mode
nvim leetcode.nvim
```

Inside Neovim:

```
<leader>lce     → Open today's daily challenge
<leader>lcr     → Run test cases  
<leader>lcs     → Submit your solution
```

---

## Keymaps Reference

### Global (work from any nvim session)

| Key | Command | What it does |
|-----|---------|-------------|
| `<leader>lc` | `:Leet` | Open/go to LeetCode menu |
| `<leader>lcq` | `:Leet list` | Browse problem list (Telescope) |
| `<leader>lce` | `:Leet daily` | Today's daily challenge |
| `<leader>lct` | `:Leet tabs` | Switch between open problems |
| `<leader>lcm` | `:Leet random` | Random problem |
| `<leader>lca` | `:Leet cookie update` | Set/update auth cookie |
| `<leader>lcx` | `:Leet cookie delete` | Sign out |

### Inside a Problem Buffer (set automatically when you open a problem)

| Key | Command | What it does |
|-----|---------|-------------|
| `<leader>lcr` | `:Leet run` | Run test cases |
| `<leader>lcs` | `:Leet submit` | Submit solution |
| `<leader>lcd` | `:Leet desc` | Toggle description panel |
| `<leader>lcc` | `:Leet console` | Toggle console (test I/O) |
| `<leader>lci` | `:Leet info` | Problem info, hints, tags |
| `<leader>lcl` | `:Leet lang` | Switch language |
| `<leader>lcy` | `:Leet yank` | Copy your solution to clipboard |
| `<leader>lcR` | `:Leet reset` | Reset to original starter code |
| `<leader>lcb` | `:Leet last_submit` | Load your last submission |
| `<leader>lco` | `:Leet open` | Open problem in browser |

### Inside Panels (description / console)

| Key | Action |
|-----|--------|
| `q` | Close the panel |
| `<CR>` | Confirm |
| `H` | Focus test case input |
| `L` | Focus result output |
| `r` | Reset test case to default |
| `U` | Use current (edited) test case |

---

## Solving a Problem

### 1. Find a problem

```
<leader>lcq
```

Telescope opens with the full problem list. Type to filter by:
- Problem number: `1`, `42`, `200`
- Name: `two sum`, `climbing stairs`
- Difficulty: `easy`, `medium`, `hard`
- Tag: `dynamic programming`, `binary search`

Press `<CR>` to open it.

### 2. Layout

```
┌──────────────────┬──────────────────────────────────┐
│                  │                                  │
│  DESCRIPTION     │   YOUR RUST SOLUTION             │
│  (left pane)     │   (right pane — .rs buffer)      │
│                  │                                  │
│  Problem text    │   impl Solution {                │
│  Examples        │       pub fn two_sum(            │
│  Constraints     │           nums: Vec<i32>,        │
│                  │           target: i32,           │
│                  │       ) -> Vec<i32> {            │
│                  │           todo!()                │
│                  │       }                          │
│                  │   }                              │
└──────────────────┴──────────────────────────────────┘
```

### 3. Write your solution

The right buffer is a `.rs` file with full Neovim features:
- `kj` → exit insert mode
- `<leader>mp` → format with rustfmt
- All your Rust snippets work (type `hmap`, `bsearch`, `uf`, etc.)
- LSP completions and hover docs

### 4. Test, iterate, submit

```
<leader>lcr    ← test cases
<leader>lcs    ← submit when happy
```

---

## Test Cases and Console

### Open the console

```
<leader>lcc
```

The console shows:
- Your output vs expected output
- Runtime / memory usage
- Compiler errors with line numbers

### Navigate the console

| Key | Action |
|-----|--------|
| `H` | Go to test case input pane |
| `L` | Go to result/output pane |
| `r` | Reset test case to problem default |
| `U` | Use your edited test case for the next run |
| `q` | Close console |

### Custom test cases

1. Open console: `<leader>lcc`
2. Press `H` to focus the input pane
3. Edit the input (it's a normal buffer)
4. Press `U` to register it
5. `<leader>lcr` to run with your custom input

---

## Rust Patterns for LeetCode

### The Solution wrapper

LeetCode wraps your code. Always implement methods on `Solution`:

```rust
impl Solution {
    pub fn problem_name(input: Vec<i32>) -> i32 {
        // your code
    }
}
```

### Common patterns

**Two Sum (HashMap O(1) lookup)**
```rust
use std::collections::HashMap;
impl Solution {
    pub fn two_sum(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let mut map = HashMap::new();
        for (i, &n) in nums.iter().enumerate() {
            if let Some(&j) = map.get(&(target - n)) {
                return vec![j as i32, i as i32];
            }
            map.insert(n, i);
        }
        unreachable!()
    }
}
```

**Sliding Window**
```rust
impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut map = std::collections::HashMap::new();
        let (mut left, mut max_len) = (0, 0);
        for (right, c) in s.chars().enumerate() {
            if let Some(&prev) = map.get(&c) {
                left = left.max(prev + 1);
            }
            map.insert(c, right);
            max_len = max_len.max(right - left + 1);
        }
        max_len as i32
    }
}
```

**Binary Search**
```rust
impl Solution {
    pub fn search(nums: Vec<i32>, target: i32) -> i32 {
        let (mut lo, mut hi) = (0i32, nums.len() as i32 - 1);
        while lo <= hi {
            let mid = lo + (hi - lo) / 2;
            match nums[mid as usize].cmp(&target) {
                std::cmp::Ordering::Equal => return mid,
                std::cmp::Ordering::Less => lo = mid + 1,
                std::cmp::Ordering::Greater => hi = mid - 1,
            }
        }
        -1
    }
}
```

**Dynamic Programming (bottom-up)**
```rust
impl Solution {
    pub fn coin_change(coins: Vec<i32>, amount: i32) -> i32 {
        let n = amount as usize + 1;
        let mut dp = vec![i32::MAX; n];
        dp[0] = 0;
        for i in 1..n {
            for &c in &coins {
                let c = c as usize;
                if c <= i && dp[i - c] != i32::MAX {
                    dp[i] = dp[i].min(dp[i - c] + 1);
                }
            }
        }
        if dp[amount as usize] == i32::MAX { -1 } else { dp[amount as usize] }
    }
}
```

**Binary Tree traversal (Rust-style)**
```rust
use std::rc::Rc;
use std::cell::RefCell;
// TreeNode is provided by LeetCode
impl Solution {
    pub fn inorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut res = vec![];
        Self::dfs(&root, &mut res);
        res
    }
    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, res: &mut Vec<i32>) {
        if let Some(n) = node {
            let n = n.borrow();
            Self::dfs(&n.left, res);
            res.push(n.val);
            Self::dfs(&n.right, res);
        }
    }
}
```

**Union-Find (for connected components / graph problems)**
```rust
// Type `uf` in insert mode to expand this snippet
struct UnionFind { parent: Vec<usize>, rank: Vec<usize> }
impl UnionFind {
    fn new(n: usize) -> Self { Self { parent: (0..n).collect(), rank: vec![0; n] } }
    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x { self.parent[x] = self.find(self.parent[x]); }
        self.parent[x]
    }
    fn union(&mut self, x: usize, y: usize) -> bool {
        let (rx, ry) = (self.find(x), self.find(y));
        if rx == ry { return false; }
        match self.rank[rx].cmp(&self.rank[ry]) {
            std::cmp::Ordering::Less => self.parent[rx] = ry,
            std::cmp::Ordering::Greater => self.parent[ry] = rx,
            std::cmp::Ordering::Equal => { self.parent[ry] = rx; self.rank[rx] += 1; }
        }
        true
    }
}
```

### Rust quirks on LeetCode

| Issue | Solution |
|-------|---------|
| LeetCode uses `i32`, not `i64` | Cast when needed: `num as i64` for intermediate math |
| Can't use external crates | Use `std::collections::*` only |
| `TreeNode` uses `Rc<RefCell<...>>` | Always borrow with `.borrow()` / `.borrow_mut()` |
| String indexing is by bytes | Use `.chars()` or `.as_bytes()` |
| `usize` subtraction can panic | Use `i32` for indices when subtraction is needed |

---

## Snippets Quick Reference

Type these in insert mode inside `.rs` files:

| Prefix | What you get |
|--------|-------------|
| `hmap` | `HashMap::new()` |
| `entry` | HashMap entry counter (`*map.entry(k).or_insert(0) += 1`) |
| `bset` | `BTreeSet` (sorted unique) |
| `maxheap` | `BinaryHeap` (max) |
| `minheap` | `BinaryHeap` with `Reverse` (min) |
| `deque` | `VecDeque` |
| `vecf` | `vec![0; n]` filled vec |
| `vec2d` | 2D grid `vec![vec![0; cols]; rows]` |
| `sort` | `sort_unstable()` |
| `sortd` | sort descending |
| `bsearch` | `binary_search` |
| `bsearchc` | custom binary search template |
| `prefix` | prefix sum array |
| `uf` | full Union-Find struct |
| `bfs` | BFS shortest path |
| `dfs` | DFS iterative |
| `dijkstra` | Dijkstra |
| `gcd` | GCD function |
| `modpow` | modular exponentiation |

---

## Recommended Problem Order

Build intuition in Rust over 5 focused weeks:

**Week 1 — Arrays & HashMaps**
- #1 Two Sum ← start here (HashMap pattern)
- #217 Contains Duplicate
- #242 Valid Anagram
- #49 Group Anagrams
- #347 Top K Frequent Elements (min-heap)

**Week 2 — Two Pointers & Sliding Window**
- #125 Valid Palindrome (`.chars()` practice)
- #167 Two Sum II (two pointers on sorted array)
- #15 3Sum
- #121 Best Time to Buy and Sell Stock
- #3 Longest Substring Without Repeating Characters

**Week 3 — Stack & Binary Search**
- #20 Valid Parentheses
- #155 Min Stack
- #704 Binary Search
- #153 Find Minimum in Rotated Sorted Array
- #33 Search in Rotated Sorted Array

**Week 4 — Trees (learn Rust's Rc<RefCell<>> here)**
- #226 Invert Binary Tree
- #104 Maximum Depth of Binary Tree
- #100 Same Tree
- #102 Level Order Traversal (BFS on tree)
- #235 Lowest Common Ancestor of BST

**Week 5+ — Dynamic Programming**
- #70 Climbing Stairs
- #198 House Robber
- #322 Coin Change ← classic DP
- #300 Longest Increasing Subsequence
- #1143 Longest Common Subsequence

---

## Troubleshooting

### "Trailing characters: auth" (or any subcommand)

You typed `:Leet auth`, `:Leet cookie update`, `:Leet run` etc. from a **regular nvim session**. These subcommands don't exist yet — the full `:Leet` API only activates after `nvim leetcode.nvim` starts the session.

**Don't use `:Leet` subcommands from regular nvim. Auth is done through the UI:**
1. `nvim leetcode.nvim`
2. Press `s` on the sign-in page
3. Paste cookie → Enter

### "Failed to initialize: neovim contains listed buffers"

The plugin can only start in a clean session. Always use:
```bash
nvim leetcode.nvim
```
Not `:Leet` from an existing session with files open.

### Cookie rejected ("Bad csrf token format" or "Bad leetcode session token format")

Your cookie string is incomplete. Make sure it contains BOTH:
- `csrftoken=<value>`
- `LEETCODE_SESSION=<value>`

Get it from the **Network tab** (not Application/Cookies). In DevTools:
1. Network tab → refresh page → click any `leetcode.com` request
2. Look in **Request Headers** for `Cookie:` 
3. Copy the **entire value** of that header

### Session expired

```bash
nvim leetcode.nvim
```

The plugin will detect the expired cookie and return you to the sign-in page. Press `s`, paste a fresh cookie string. LeetCode sessions typically last a few weeks.

If already in a running session, you can also use `:Leet cookie update`.

### TSUpdate html fails

```
:TSInstall html
```

Run this manually and try again.

### Plugin not loading at all

Make sure you ran `:Lazy sync` after adding the plugin to install it. Also verify the plugin is in the lazy list:
```
:Lazy
```
Find `leetcode.nvim` and press `i` to install if needed.

---

*Solutions stored at: `~/.local/share/nvim/leetcode/`*
