from queue import Queue

infl = 1000000000
stage = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 0, 0, 0, 1, 0, 0, 0],
    [0, 1, 0, 1, 1, 1, 1, 1, 0],
    [0, 0, 0, 1, 0, 0, 0, 1, 0],
    [0, 1, 1, 1, 1, 1, 0, 1, 0],
    [0, 0, 0, 1, 0, 1, 0, 0, 0],
    [0, 1, 1, 1, 0, 1, 1, 1, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
]
h, w = 9, 9
way = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
]

q = Queue()
q.put([1, 1])
visited = [[False for _ in range(w)] for _ in range(h)]
visited[1][1] = True
depth = [[infl for _ in range(w)] for _ in range(h)]
depth[1][1] = 0

while not q.empty():
    dest = q.get()
    for vect in way:
        dy = dest[0] + vect[0]
        dx = dest[1] + vect[1]
        if dy < 0 or dy >= h or dx < 0 or dx >= w:
            continue
        if not stage[dy][dx]:
            continue
        if not visited[dy][dx]:
            visited[dy][dx] = True
            depth[dy][dx] = depth[dest[0]][dest[1]] + 1
            q.put([dy, dx])

for line in depth:
    lf = list((elm if elm != infl else -1) for elm in line)
    for elm in lf:
        print("{0:2d}".format(elm), sep=" ", end=" ")
    print()
