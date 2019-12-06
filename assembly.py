
# this program will make the code that makes the assembly
# print("Hello")

opcode = {'add':0b000, 'sub':0b001, 'mult':0b010, 'div': 0b011, 'addc':0b100, 'subc':0b101, 'multc':0b110, 'divc': 0b111}
# opcode1 = {'add':0, 'sub':1, 'mult':2, 'div': 3, 'addc':4, 'subc':5, 'multc':6, 'divc': 7}
opcode = {'add':'000', 'sub':'001', 'mult':'010', 'div': '011', 'addc':'100', 'subc':'101', 'multc':'110', 'divc': '111'}

t = {}
def print_bin(a):
    print(a)

def toDecToBin(x):
    return bin(x)

def write_assembly():
    Code =[
        ['addc', 2, 3],
        ['addc', 45, 0]
    ]

    # print(Code[0])
    # print(Code)

    for i in Code:
        # print(opcode[i[0]])
        # print(toDecToBin(i[1]))
        # print(toDecToBin(i[2]))

        imm1 = str(bin(i[1]))
        imm1len = len(imm1[2:])
        padding1 = ''
        for c in range(0,16-imm1len):
            padding1 += '0'
        imm1 = imm1[0:2] + padding1 + imm1[2:]
        # print("imm1 ", imm1)
        # print(len(imm1))
        # print(int(imm1, 2))
        imm2 = str(bin(i[2]))
        imm2len = len(imm2[2:])
        padding2 = ''
        for c in range(0,16-imm2len):
            padding2 += '0'
        imm2 = imm2[0:2] + padding2 + imm2[2:]
        # print("imm2 ", imm2)
        Inc = str(imm1[0:2])+ opcode[i[0]] + imm1[2:] + imm2[2:]
        print(hex(int(Inc, 2)))
        # print(len(Inc))




def main():
    # num = bin(10);
    # print_bin(num)
    write_assembly()
if __name__ ==  '__main__':
    main()
