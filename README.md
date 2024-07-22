# Partitions
This is inspired by [Gsheaf's Fibsonicci project](https://github.com/GSheaf/Fibsonicci). Generally, I want to look at integer number sequences and their algorithmic design. Why not start with partitions?

# C++
So I write out partition_naive.cpp, partition_euler.cpp, and partition_euler_nomemo.cpp; partition_naive uses dynamic programming to partition each integer, whereas the Eulerian programs use the pentagonal number theorem. At this point, a pretty prominent problem displays itself: arbitrary-number precision is hard to actualize (GMP and Boost, among others, aren't great to work with on VSCode on a Mac). I originally set a breaking point at 400 but this is too small of a cutoff in my opinion to observe interesting behavior. Additionally, running partition_euler_nomemo.cpp seems impossible. Without memoization, the program is just stuck. No worries; this is why program optimization is a thing. From here, I shift to using Julia instead.
