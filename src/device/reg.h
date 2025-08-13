#ifndef __DEVICE_REG_H__
#define __DEVICE_REG_H__


#define REGISTER_BASE   (0x00001000)
#define REGISTER0       (*(volatile uint32_t*)(REGISTER_BASE + 0x00))
#define REGISTER1       (*(volatile uint32_t*)(REGISTER_BASE + 0x04))
#define REGISTER2       (*(volatile uint32_t*)(REGISTER_BASE + 0x08))
#define REGISTER3       (*(volatile uint32_t*)(REGISTER_BASE + 0x0C))


#endif /* __DEVICE_REG_H__ */
