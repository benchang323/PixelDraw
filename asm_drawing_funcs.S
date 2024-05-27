/*
* Assembly-language implementations of the drawing functions
*/

/* Offsets of struct Image fields */
#define IMAGE_WIDTH_OFFSET   0
#define IMAGE_HEIGHT_OFFSET  4
#define IMAGE_DATA_OFFSET    8

/* Offsets of struct Rect fields */
#define RECT_X_OFFSET        0
#define RECT_Y_OFFSET        4
#define RECT_WIDTH_OFFSET    8
#define RECT_HEIGHT_OFFSET   12

  .section .text
/***********************************************************************
 Helper functions
 You should declare these as .globl so that
 they can be called from the unit test code.
***********************************************************************/
/*
* Get the alpha component of a color.
* Parameters:
*   %edi - color (uint32_t)
*/
  .globl get_a
get_a:
  movl %edi, %eax
  andl $0xFF, %eax
  ret

/*
* Get the red component of a color.
* Parameters:
*   %edi - color (uint32_t)
*/
  .globl get_r
get_r:
  movl %edi, %eax
  shrl $24, %eax
  andl $0xFF, %eax
  ret

/*
* Get the green component of a color.
* Parameters:
*   %edi - color (uint32_t)
*/
  .globl get_g
get_g:
  movl %edi, %eax
  shrl $16, %eax
  andl $0xFF, %eax
  ret

/*
* Get the blue component of a color.
* Parameters:
*   %edi - color (uint32_t)
*/
  .globl get_b
get_b:
  movl %edi, %eax
  shrl $8, %eax
  andl $0xFF, %eax
  ret

/*
* Square a number.
* Parameters:
*   %rdi - x (int64_t x)
*/
  .globl square
square:
  imulq %rdi, %rdi
  movq %rdi, %rax
  ret

/*
* Compute the index in row-major order.
* Parameters:
*  %rdi - pointer to struct Image
*  %esi - x coordinate
*  %edx - y coordinate
*/
  .globl compute_index
compute_index:
  movl IMAGE_WIDTH_OFFSET(%rdi), %eax
  imull %edx, %eax
  addl %esi, %eax
  ret

/*
* Check if image is in bounds.
* Parameters:
*  %rdi - pointer to struct Image
*  %esi - x coordinate
*  %edx - y coordinate
*/
  .globl in_bounds
in_bounds:
  /* Check Null */
  cmp $0, %rdi
  je NULL

  /* if x < 0 */
  cmp $0, %esi
  jl OOBB

  /* if x >= img->width */
  cmpl IMAGE_WIDTH_OFFSET(%rdi), %esi
  jge OOBB

  /*if y < 0 */
  cmpl $0, %edx
  jl OOBB

  /* if y >= img->height */
  cmpl IMAGE_HEIGHT_OFFSET(%rdi), %edx
  jge OOBB

  movl $1, %eax
  ret

  NULL:
    movl $0, %eax
    ret

  OOBB:
    movl $0, %eax
    ret

/*
* Blend two components.
* Parameters:
*  %edi - foreground color
*  %esi - background color
*  %edx - alpha
*/
  .globl blend_components
blend_components:
  pushq %rbx
  subq $8, %rsp
  cmp $0xFF, %edx
  je ReturnFG

  /* (0xFF) - alpha */
  movl $0xFF, %eax
  subl %edx, %eax

  /* ((0xFF) - alpha) * bg */
  imull %esi, %eax

  /* alpha * fg */
  movl %edi, %ebx
  imull %edx, %ebx

  /* (alpha * fg + ((0xFF) - alpha) * bg) */
  addl %ebx, %eax

  /* ((alpha * fg + ((0xFF) - alpha) * bg) / 255) */
  xorl %edx, %edx
  movl $255, %ebx
  divl %ebx
 
  addq $8, %rsp
  popq %rbx

  /* Return */
  ret

  ReturnFG:
    movl %edi, %eax
    addq $8, %rsp
    popq %rbx
    ret


/*
* Blends the color.
* Parameters:
*  %edi - foreground color
*  %esi - background color
*/
.globl blend_colors
blend_colors:
  /* Alignment and saving callee-saved registers */
  pushq %rbx
  pushq %rbp
  pushq %r12
  pushq %r13
  pushq %r14
  pushq %r15
  subq $8, %rsp

  /* fg and bg */
  /* foreground color */
  movl %edi, %ebx  

  /* background color */
  movl %esi, %ebp  

  /* red components */
  /* fg red */
  movl %ebx, %edi
  call get_r

  /* use callee-saved register for red component */
  movl %eax, %r12d  

  /* bg red */
  movl %ebp, %edi
  call get_r
  /* use callee-saved register for background red component */
  movl %eax, %r13d  

  /* get alpha */
  movl %ebx, %edi
  call get_a
  movl %eax, %r15d

  /* blend red */
  movl %r12d, %edi
  movl %r13d, %esi
  movl %eax, %edx
  call blend_components

  /* store red */
  shll $24, %eax

  /* use another callee-saved register for combined color */
  movl %eax, %r14d  

  /* green components */
  /* fg green */
  movl %ebx, %edi
  call get_g
  movl %eax, %r12d

  /* bg green */
  movl %ebp, %edi
  call get_g
  movl %eax, %r13d

  /* blend green */
  movl %r12d, %edi
  movl %r13d, %esi
  movl %r15d, %edx
  call blend_components

  /* store green */
  shll $16, %eax
  orl %eax, %r14d

  /* blue components */
  /* fg blue */
  movl %ebx, %edi
  call get_b
  movl %eax, %r12d

  /* bg blue */
  movl %ebp, %edi
  call get_b
  movl %eax, %r13d

  /* blend blue */
  movl %r12d, %edi
  movl %r13d, %esi
  movl %r15d, %edx
  call blend_components

  /* store blue */
  shll $8, %eax
  orl %eax, %r14d

  /* store color */
  orl $0xFF, %r14d
  movl %r14d, %eax

  /* Return and realign, restoring callee-saved registers */
  addq $8, %rsp
  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %rbp
  popq %rbx
  ret

/*
* Register use:
* %rbx - pointer to img
* %r12 - pointer to rect
* %r13 - inner loop index
* %r14 - outer loop index
* %r15 - extra register aligns stack
/*
* Check the bounds for rect
* Parameters:
*  %rdi - pointer to struct Image.
*  %rsi - pointer to struct Rect.
*/
  .globl check_rect_bounds
check_rect_bounds:	
  pushq %rbx //pushing register to hold img pointer
  pushq %r12 //pushing register to hold rect pointer
  pushq %r13 //pushing register for inner loop counter
  pushq %r14 //pushing register for outer loop counter
  pushq %r15 //extra register, aligns stack

  /* Save img pointer local */
  movq %rdi, %rbx 

  /* save rect pointer local */
  movq %rsi, %r12 

  /* i, width */
  movq $0, %r14 

  .LForLoop1:
    cmpl RECT_WIDTH_OFFSET(%r12), %r14d //comparing if index out of bounds
    jge .LDone //if so, finish loops
    movl $0, %r13d // j , height	
  .LForLoop2:
    cmpl RECT_HEIGHT_OFFSET(%r12), %r13d //comparing if inner loop index out of bounds
    jge .Linc1 //if so go back to forloop1 and increment
    movq %rbx, %rdi //save into registers to call in_bounds
    movl %r14d, %esi //moving i in prepration to call in_bounds
    addl RECT_X_OFFSET(%r12), %esi //adding x offset to i
    movl %r13d, %edx //moving j in prepratino to call in_bounds
    addl RECT_Y_OFFSET(%r12), %edx //adding y offset to j
    call in_bounds //checking if everything is in bounds
    cmpq $0, %rax //return code 0 if out bounds
    je .LOOB   //jump if 0 is returned
    incl %r13d //increment inner loop
    jmp .LForLoop2 //loop back to inner loop
  .Linc1:
    movl $0, %r13d //reset inner loop
    incl %r14d //increment outer loop
    jmp .LForLoop1 //jump to outer loop
  .LOOB:
    movq $0, %rax //return with 0 if OOB  
    jmp .LExit //go to exit lable
  .LDone:
    movq $1, %rax //return with 1 if in bounds
  .LExit:
    popq %r15 //restoring r15
    popq %r14 //restoring r14
    popq %r13 //restoring r13
    popq %r12 //restoring r12
    popq %rbx //restoring rbx
    ret //return
  









/***********************************************************************
 Public API functions
***********************************************************************/
/*
* Draw a pixel.
*
* Parameters:
*   %rdi     - pointer to struct Image
*   %esi     - x coordinate (pixel column)
*   %edx     - y coordinate (pixel row)
*   %ecx     - uint32_t color value
*/
.globl draw_pixel
draw_pixel:
  /* Alignment */
  pushq %rbp
  pushq %r12
  pushq %r13
  pushq %r14
  pushq %r15

  /* Save callee-saved registers */
  movq %rdi, %r12
  movl %esi, %r13d
  movl %edx, %r14d
  movl %ecx, %r15d

  call in_bounds

  /* Draw pixel */
  cmpl $0, %eax
  je Return

  movq %r12, %rdi
  movl %r13d, %esi
  movl %r14d, %edx

  /* Compute Index */
  call compute_index
  movq IMAGE_DATA_OFFSET(%r12), %r12
  leaq (%r12, %rax, 4), %r15

  /*Get color from computed_index */
  movl (%r15), %esi

  /* Blend Colors, use computed index and store background color to esi*/
  /* Foreground */
  movl %ecx, %edi 
  call blend_colors

  /* set color to image */
  movl %eax, (%r15)

  /* Return and Realign */
  Return:
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbp
    ret

/*
* Draw a rectangle.
* The rectangle has rect->x,rect->y as its upper left corner,
* is rect->width pixels wide, and rect->height pixels high.
*
* Parameters:
*   %rdi     - pointer to struct Image
*   %rsi     - pointer to struct Rect
*   %edx     - uint32_t color value
*/
	.globl draw_rect
draw_rect:
  /* Alignment */
	pushq %rbp
  pushq %rbx
  pushq %r12        
  pushq %r13
  pushq %r14
  pushq %r15
  subq $8, %rsp

	/* saving param data into local */
  movq %rdi, %rbx
	mov %rsi, %rbp
	movq %rdx, %r12

	/* Counter */
	xor %r14d, %r14d

.LRectLoop1:
	/* Compare i and width */	
  /* Outer Count */
	cmpl RECT_WIDTH_OFFSET(%rbp), %r14d

	/* If i >= width, jump to Normal */
	jge Normal

	/* Counter */
  /* Inner Count */
	xor %r15d, %r15d

.LRectLoop2:
	/* Compare j and height */
	cmpl 12(%rbp), %r15d

	/* If j >= height, break loop */
	jge Inc

	/* Draw pixel */
	/* start_x + i, start_y + j */
	movq %rbx, %rdi
  movq RECT_X_OFFSET(%rbp), %rsi
  addq %r14, %rsi
  movq RECT_Y_OFFSET(%rbp), %rdx
  addq %r15, %rdx
  movq %r12, %rcx
	call draw_pixel

	/* Increment Counter */
	incl %r15d
	jmp .LRectLoop2

Inc:
	/* Increment Counter */
	incl %r14d
	jmp .LRectLoop1

Normal:
  addq $8, %rsp
  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %rbx
  popq %rbp
	ret

/*
* Draw a circle.
* The circle has x,y as its center and has r as its radius.
*
* Parameters:
*   %rdi     - pointer to struct Image
*   %esi     - x coordinate of circle's center
*   %edx     - y coordinate of circle's center
*   %ecx     - radius of circle
*   %r8d     - uint32_t color value
*/
  .globl draw_circle
draw_circle:
  /* Save callee-saved registers and allocate stack space */
  /* Save rbx register*/
  pushq %rbx          

  /* Save r12 register */
  pushq %r12    

  /* Save r13 register */    
  pushq %r13    

  /* Save r14 register */
  pushq %r14       

  /* Save r15 register */
  pushq %r15           

  /* Allocate stack space for local variables */
  subq $64, %rsp      

  /* Save arguments passed via registers on stack */
  /* image pointer */
  movq %rdi, %rbx      

  /* x-center of circle */
  movl %esi, 8(%rsp)   

  /* y-center of circle */
  movl %edx, 12(%rsp)  
  
  /* radius of circle */
  movl %ecx, 16(%rsp)  

  /* color */
  movl %r8d, 20(%rsp)  
  
  /* x-coordinate counter */
  /* Load x-center */
  movl 8(%rsp), %r12d  

  /* Subtract radius from left edge of circle */
  subl 16(%rsp), %r12d
  
  /* x-coordinate end point */
  /* Load x-center */
  movl 8(%rsp), %r13d 

  /* Add radius to end at right edge of circle */
  addl 16(%rsp), %r13d 

/* Start of the first loop */
.LCircleLoop1: 
  /* Check if counter exceeds x-coordinate */
  cmpl %r13d, %r12d

  /* If greater, drawing circle is done */
  jg .LCircleDone 

  /* y-coordinate counter */
  /* Load y-center */
  movl 12(%rsp), %r14d 

  /* Subtract radius to start from top edge of circle */
  subl 16(%rsp), %r14d 

  /* y-coordinate end point */
  /* Load y-center */
  movl 12(%rsp), %r15d 

  /* Add radius to end at bottom edge of circle */
  addl 16(%rsp), %r15d 

/* Start of the second loop */
.LCircleLoop2: 
  /* Check if counter exceeds y-coordinate */
  cmpl %r15d, %r14d

  /* If greater, increment x-coordinate */
  jg .LincCL 

  /* Calculate squared distance from x-center  */
  movq %r12, %rdi

  /* Load x-center */
  subq 8(%rsp), %rdi

  /* Call square function */
  call square

  /* Store result temporarily */ 
  movl %eax, 24(%rsp)

  /* calculate squared distance from y-center to current y */
  movq %r14, %rdi

  /* Load y-center */
  subq 12(%rsp), %rdi

  /* Call square function */
  call square

  /* Calculate squared radius for comparison */
  /* Add squared distances */
  addl %eax, 24(%rsp) 

  /* Load radius */
  movq 16(%rsp), %rdi 

  /* Square the radius */
  call square        

  /* Compare squared distances with squared radius */
  cmpl %eax, 24(%rsp)

  /* OOB, Next */
  jg .LCircleContinue 

  /* Draw pixel at calculated point */
  /* Load image pointer */
  movq %rbx, %rdi  

  /* Set x-coordinate */   
  movl %r12d, %esi 

  /* Set y-coordinate */   
  movl %r14d, %edx   

  /* Set color */ 
  movl 20(%rsp), %ecx 

  /* Call drawing function */
  call draw_pixel     

.LCircleContinue:
  /* Increment y-coordinate counter */
  incl %r14d

  /* Jump back to the start of inner loop */
  jmp .LCircleLoop2   

.LincCL:
  /* Increment x-coordinate counter */
  incl %r12d

  /* Jump back to the start of outer loop */
  jmp .LCircleLoop1 

.LCircleDone:
  /* Clean up stack */
  /* Deallocate local variables space */
  addq $64, %rsp   

  /* Restore r15 register */
  popq %r15  

  /* Restore r14 register */         
  popq %r14   

  /* Restore r13 register */
  popq %r13   

  /* Restore r12 register */
  popq %r12   

  /* Restore rbx register */     
  popq %rbx  

  /* Return from function */    
  ret                 


/*
* Register Use:
* %rbp - pointer to dest Image
* %rbx - tilemap data
* %r12 - outer loop index
* %r13 - inner loop index
* %r14 - pointer to tilemap
* %r15 - pointer to tile rect
*  Stack Use (24 bytes allocated)
* 8(%rsp) - x coordinate
* 16(%rsp) - y coordinate
/*
* Draw a tile by copying all pixels in the region
* enclosed by the tile parameter in the tilemap image
* to the specified x/y coordinates of the destination image.
* No blending of the tile pixel colors with the background
* colors should be done.
*
* Parameters:
*   %rdi - pointer to Image (dest image)
*   %esi - x coordinate of location where tile should be copied
*   %edx - y coordinate of location where tile should be copied
*   %rcx - pointer to Image (the tilemap)
*   %r8  - pointer to Rect (the tile)
*/
  .globl draw_tile
draw_tile:
	
	pushq %rbp //pushing register to hold dest img pointer
	pushq %rbx //pushing register to hold tilemap data
	pushq %r12 //pushing register to hold outer loop index
	pushq %r13 //pushing register to hold inner loop index
	pushq %r14 //pushing register to hold tilemap pointer
	pushq %r15 //pushing register to hold tile rect pointer
  
	subq $24, %rsp //allocating space for local varaibles
  movl %esi, 8(%rsp) //storing x in stack frame
  movl %edx, 16(%rsp) //storing y in stack frame
  movq %rdi, %rbp //saving img destination pointer to local
	movq %rcx, %r14 //saving tilemap pointer to local
	movq %r8,  %r15 //saving rect pointer to local
  
  movq %r14, %rdi //moving tilemap pointer back to rdi to prepare check_rect_bounds call
  movq %r15, %rsi //moving tile rect pointer back to rsi to prepare check_rect_bounds call
	call check_rect_bounds//checking if current x,y inbounds
	cmpq $0, %rax //comparing result
	je .Lret //return if they are equal
	

  /* comparing result */
	cmpq $0, %rax 

  /* return if they are equal */
	je .Lret 

  /* initialzing counter to 0 */
  xor %r12d, %r12d 

	.LTileloop1:
    /* check if coutner past bound */
    cmpl RECT_WIDTH_OFFSET(%r15), %r12d 

    /* exit loop if past */
    jge .Lret 

    /* initalize nested loop pointer to 0 */
    xor %r13d, %r13d

  .LTileloop2:
    /* check if counter past bound */
    cmpl RECT_HEIGHT_OFFSET(%r15), %r13d 

    /* jump to increment outer loop and start inner loop over */
    jge .Linc2 

    /* moving img destination pointer back to rdi to prepare to call in_bounds */
    movq %rbp, %rdi 

    /* preparing to call boudns by saving current outer loop index into esi */
    movl %r12d, %esi 

    /* adding x offset to prepare to call in_bounds */
    addl 8(%rsp), %esi 

    /* preparing to call bounds by saving current inner loop index into edx */
    movl %r13d, %edx 

    /* adding y offset */
    addl 16(%rsp), %edx 

    /* check if current index in for loop is in_bounds */
    call in_bounds 

    /* comparing result of bound check */
    cmpl $0, %eax 

    /* return if it is out of bounds */
    je .Lcontinue2 

    /* tilemap ind */
    /* moving img pointer back to rdi to prepare to call compute_index */
    movq %r14, %rdi 

    /* moving rectangle x offset to esi to prepare to compute data index */
    movl RECT_X_OFFSET(%r15), %esi 

    /* adding current index to esi to prepare to call index */
    addl %r12d, %esi 

    /* moving rectangle y offset to edx to prepare to compute data index */
    movl RECT_Y_OFFSET(%r15), %edx 

    /* adding current index to edx to prepare to call index */
    addl %r13d, %edx 

    /* calling compute index so that we access the correct data value in the tilemap */
    call compute_index 

    /* save image data pointer to r9 */
    movq IMAGE_DATA_OFFSET(%r14), %r9 

    /* saving tilemap_ind_data that is found by compute_index */
    movl (%r9, %rax, 4), %ebx 

    /* calc destination index */
    /* moving tilemap img pointer to rdi to prepare to call compute_index */
    movq %rbp, %rdi

    /* moving x coordinate of where tile should be copied to prepare to compute index */
    movl 8(%rsp), %esi 

    /* adding outer loop index to x to prepare to compute index */
    addl %r12d, %esi 

    /*  moving y coordinate of where tile should be copied to prepare to compute index */
    movl 16(%rsp), %edx 

    /* adding inner loop index to y to prepare to compute index */
    addl %r13d, %edx

    /* computing destination index */
    call compute_index 

    /* find address of data pointers */
    movq IMAGE_DATA_OFFSET(%rbp), %r9 

    /* find specific address of where to copy the individual color to and put the color there */
    movl %ebx, (%r9, %rax, 4) 

	.Lcontinue2:
    /* increment inner loop */
    incl %r13d 
    /* loop back to start of inner loop */
    jmp .LTileloop2 
	
	.Lret:
    addq $24, %rsp //deallocating space
    popq %r15 //restoring r15
    popq %r14 //restoring r14
    popq %r13 //restoring r13
    popq %r12 //restoring r12
    popq %rbx //restoring rbx
    popq %rbp //restoring rbp
	  ret

	.Linc2:
    /* increasing outer loop index */
    incl %r12d 

    /* loop back to start of outer loop */
    jmp .LTileloop1 
  ret

/*
* Draw a sprite by copying all pixels in the region
* enclosed by the sprite parameter in the spritemap image
* to the specified x/y coordinates of the destination image.
* The alpha values of the sprite pixels should be used to
* blend the sprite pixel colors with the background
* pixel colors.
*
* Parameters:
*   %rdi - pointer to Image (dest image)
*   %esi - x coordinate of location where sprite should be copied
*   %edx - y coordinate of location where sprite should be copied
*   %rcx - pointer to Image (the spritemap)
*   %r8  - pointer to Rect (the sprite)
*/
  .globl draw_sprite
draw_sprite:
  /* Save base pointer and registers */
  /* Save rbp register */
  pushq %rbp

  /* Save rbx register */
  pushq %rbx

  /* Save r12 register */
  pushq %r12

  /* Save r13 register */
  pushq %r13

  /* Save r14 register */
  pushq %r14

  /* Save r15 register */
  pushq %r15

  /* Align Stack */
  movq %rsp, %rbp 

  /* allocate space for local variables */
  subq $44, %rsp 

  /* Store function arguments into local variables on stack */
  /* image pointer */
  movq %rdi, -8(%rbp) 

  /* x coordinate */
  movl %esi, -12(%rbp)

  /* y coordinate */
  movl %edx, -16(%rbp) 

  /* source image */
  movq %rcx, -24(%rbp)

  /* pointer to sprite */
  movq %r8, -32(%rbp)  

  /* Y + Height */
  /* Load Y offset */
  movl RECT_Y_OFFSET(%r8), %r9d 

  /* Add sprite height */
  addl RECT_HEIGHT_OFFSET(%r8), %r9d 

  /* Store result */
  movl %r9d, -40(%rbp) 

  /* X + Width */
  /* Load X offset */
  movl RECT_X_OFFSET(%r8), %ebx 

  /* Add sprite width */
  addl RECT_WIDTH_OFFSET(%r8), %ebx 

  /* X + sprite within image bounds */
  /* Compare with spritemap width */
  cmpl %ebx, IMAGE_WIDTH_OFFSET(%rcx) 

  /* Jump to end if OOB */
  jle .EndSprite 

  /* Bounds check: Y + sprite height must be within image bounds */
  /* Load Y + Height */
  movl -40(%rbp), %r9d 

  /* Compare with spritemap height */
  cmpl %r9d, IMAGE_HEIGHT_OFFSET(%rcx)

  /* Jump to end if OOB */
  jle .EndSprite 

  /* Y-sprite counter for outer loop */
  movl RECT_Y_OFFSET(%r8), %r12d 

/* Outer Loop */
.SpriteL1:
  /* Check if Y index is OOB */
  /* Compare Y with Y + Height */
  cmpl -40(%rbp), %r12d 

  /* Exit if Yis greater or equal */
  jge .EndSprite 

  /* Initialize X-sprite counter for inner loop */
  movl RECT_X_OFFSET(%r8), %r13d // Load X offset of the sprite into %r13d for iteration

.SpriteL2:
  /* Compare current X with X + Width */
  cmpl %ebx, %r13d 
  
  /* OOB, Exit */
  jge .SpriteNextL2 

  /* Y index to %r15d */
  movl %r12d, %r15d 

  /* sprite rectangle pointer */
  movq -32(%rbp), %r8 

  /* Subtract Y offset of the sprite */
  subl RECT_Y_OFFSET(%r8), %r15d 

  /* Add destination Y coordinate */
  addl -16(%rbp), %r15d 

  /* X index to %r14d */
  movl %r13d, %r14d 

  /* sprite rectangle pointer */
  movq -32(%rbp), %r8 

  /* Subtract X offset of the sprite */
  subl RECT_X_OFFSET(%r8), %r14d 

  /* destination X coordinate */
  addl -12(%rbp), %r14d 

  /* destination image pointer */
  movq -8(%rbp), %rdi 

  /* Y coordinate for bounds check */
  movl %r15d, %edx 

  /* X coordinate for bounds check */
  movl %r14d, %esi 

  /* check if coordinates are within bounds */
  call in_bounds 

  /* Compare return value */
  cmpl $1, %eax 

  /* Skip, OOB */
  jne .SpriteNextL1 

  /* source image (spritemap) pointer */
  movq -24(%rbp), %rdi 

  /* Y index for color retrieval */
  movl %r12d, %edx 

  /* X index for color retrieval */
  movl %r13d, %esi 

  /* compute color index */
  call compute_index 

  /* source image pointer */
  movq -24(%rbp), %r10 

  /* image data pointer */
  movq IMAGE_DATA_OFFSET(%r10), %r11 

  /* Retrieve color */
  movl (%r11, %rax, 4), %r11d 

  /* Store color for drawing */
  movl %r11d, -36(%rbp) 

  /* destination image pointer */
  movq -8(%rbp), %rdi 

  /* color to be drawn */
  movl -36(%rbp), %ecx 

  /* X coordinate for drawing */
  movl %r14d, %esi 

  /* Y coordinate for drawing */
  movl %r15d, %edx 

  /* Call draw pixel */
  call draw_pixel 


  /* Increment X index */
  inc %r13d 

  /* Jump back to start of loop */
  jmp .SpriteL2 

.SpriteNextL1:
  /* Increment X index  */
  inc %r13d 

  /* Back to start of inner loop */
  jmp .SpriteL2 

.SpriteNextL2:
  /* Increment Y index */
  inc %r12d 
  
  /* Jump back to outer loop */
  jmp .SpriteL1 

.EndSprite:
  /* Realignment */
  /* Restore r12 register */
  popq %r12

  /* Restore r13 register */
  popq %r13

  /* Restore r14 register */
  popq %r14

  /* Restore r15 register */
  popq %r15

  /* Restore rbx register */
  popq %rbx

  /* Rsp reallocate */
  addq $44, %rsp 

  /* Restore rbp register */
  popq %rbp
  ret


/*
vim:ft=gas:
*/





